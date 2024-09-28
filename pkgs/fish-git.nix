{
  stdenv,
  lib,
  fetchFromGitHub,
  gnugrep,
  gnused,
  mandoc,
  gawk,
  man-db,
  getent,
  libiconv,
  pcre2,
  gettext,
  python3,
  cmake,
  fishPlugins,
  rustPlatform,
  rustc,
  cargo,
  writeText,
  # used to generate autocompletions from manpages and for configuration editing in the browser
  usePython ? true,
  useOperatingSystemEtc ? true,
  # An optional string containing Fish code that initializes the environment.
  # This is run at the very beginning of initialization. If it sets $NIX_PROFILES
  # then Fish will use that to configure its function, completion, and conf.d paths.
  # For example:
  #   fishEnvPreInit = "source /etc/fish/my-env-preinit.fish";
  # It can also be a function that takes one argument, which is a function that
  # takes a path to a bash file and converts it to fish. For example:
  #   fishEnvPreInit = source: source "${nix}/etc/profile.d/nix-daemon.sh";
  fishEnvPreInit ? null,
}: let
  inherit (lib) optionalString;

  etcConfigAppendix = writeText "config.fish.appendix" ''
    ############### ↓ Nix hook for sourcing /etc/fish/config.fish ↓ ###############
    #                                                                             #
    # Origin:
    #     This fish package was called with the attribute
    #     "useOperatingSystemEtc = true;".
    #
    # Purpose:
    #     Fish ordinarily sources /etc/fish/config.fish as
    #        $__fish_sysconfdir/config.fish,
    #     and $__fish_sysconfdir is defined at compile-time, baked into the C++
    #     component of fish. By default, it is set to "/etc/fish". When building
    #     through Nix, $__fish_sysconfdir gets set to $out/etc/fish. Here we may
    #     have included a custom $out/etc/config.fish in the fish package,
    #     as specified, but according to the value of useOperatingSystemEtc, we
    #     may want to further source the real "/etc/fish/config.fish" file.
    #
    #     When this option is enabled, this segment should appear the very end of
    #     "$out/etc/config.fish". This is to emulate the behavior of fish itself
    #     with respect to /etc/fish/config.fish and ~/.config/fish/config.fish:
    #     source both, but source the more global configuration files earlier
    #     than the more local ones, so that more local configurations inherit
    #     from but override the more global locations.
    #
    #     Special care needs to be taken, when fish is called from an FHS user env
    #     or similar setup, because this configuration file will then be relocated
    #     to /etc/fish/config.fish, so we test for this case to avoid nontermination.

    if test -f /etc/fish/config.fish && test /etc/fish/config.fish != (status filename)
      source /etc/fish/config.fish
    end

    #                                                                             #
    ############### ↑ Nix hook for sourcing /etc/fish/config.fish ↑ ###############
  '';

  fishPreInitHooks = writeText "__fish_build_paths_suffix.fish" ''
    # source nixos environment
    # note that this is required:
    #   1. For all shells, not just login shells (mosh needs this as do some other command-line utilities)
    #   2. Before the shell is initialized, so that config snippets can find the commands they use on the PATH
    builtin status is-login
    or test -z "$__fish_nixos_env_preinit_sourced" -a -z "$ETC_PROFILE_SOURCED" -a -z "$ETC_ZSHENV_SOURCED"
    ${
      if fishEnvPreInit != null
      then ''
        and begin
        ${lib.removeSuffix "\n" (
          if lib.isFunction fishEnvPreInit
          then fishEnvPreInit sourceWithFenv
          else fishEnvPreInit
        )}
        end''
      else ''
        and test -f /etc/fish/nixos-env-preinit.fish
        and source /etc/fish/nixos-env-preinit.fish''
    }
    and set -gx __fish_nixos_env_preinit_sourced 1

    test -n "$NIX_PROFILES"
    and begin
      # We ensure that __extra_* variables are read in $__fish_datadir/config.fish
      # with a preference for user-configured data by making sure the package-specific
      # data comes last. Files are loaded/sourced in encounter order, duplicate
      # basenames get skipped, so we assure this by prepending Nix profile paths
      # (ordered in reverse of the $NIX_PROFILE variable)
      #
      # Note that at this point in evaluation, there is nothing whatsoever on the
      # fish_function_path. That means we don't have most fish builtins, e.g., `eval`.


      # additional profiles are expected in order of precedence, which means the reverse of the
      # NIX_PROFILES variable (same as config.environment.profiles)
      set -l __nix_profile_paths (string split ' ' $NIX_PROFILES)[-1..1]

      set -p __extra_completionsdir \
        $__nix_profile_paths"/etc/fish/completions" \
        $__nix_profile_paths"/share/fish/vendor_completions.d"
      set -p __extra_functionsdir \
        $__nix_profile_paths"/etc/fish/functions" \
        $__nix_profile_paths"/share/fish/vendor_functions.d"
      set -p __extra_confdir \
        $__nix_profile_paths"/etc/fish/conf.d" \
        $__nix_profile_paths"/share/fish/vendor_conf.d"
    end
  '';

  # This is wrapped in begin/end in case the user wants to apply redirections.
  # This does mean the basic usage of sourcing a single file will produce
  # `begin; begin; …; end; end` but that's ok.
  sourceWithFenv = path: ''
    begin # fenv
      # This happens before $__fish_datadir/config.fish sets fish_function_path, so it is currently
      # unset. We set it and then completely erase it, leaving its configuration to $__fish_datadir/config.fish
      set fish_function_path ${fishPlugins.foreign-env}/share/fish/vendor_functions.d $__fish_datadir/functions
      fenv source ${lib.escapeShellArg path}
      set -l fenv_status $status
      # clear fish_function_path so that it will be correctly set when we return to $__fish_datadir/config.fish
      set -e fish_function_path
      test $fenv_status -eq 0
    end # fenv
  '';
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "fish";
    version = "2024-09-28";

    src = fetchFromGitHub {
      owner = "fish-shell";
      repo = "fish-shell";
      rev = "263f1b35de01cb04a6c2cbc635ae0258f8401a3f";
      hash = "sha256-LbSL1Q06+fkxVpWuX4BGhP48KYJX0jI2YoENkuetUd8=";
    };

    outputs = ["out" "doc"];
    strictDeps = true;
    nativeBuildInputs = [
      cmake
      gettext
      rustc
      cargo
      rustPlatform.cargoSetupHook
    ];

    buildInputs = [
      libiconv
      pcre2
    ];

    cargoDeps = rustPlatform.importCargoLock {
      lockFile = finalAttrs.src + /Cargo.lock;
      outputHashes."pcre2-0.2.9" = "sha256-uYJgQuAKYaOdaMkI9MHf2viHT1BkFAaaG6v/vN3hElY=";
    };

    cmakeFlags =
      [
        "-DCMAKE_BUILD_TYPE=Release"
        "-DCMAKE_INSTALL_DOCDIR=${placeholder "doc"}/share/doc/fish"
      ]
      ++ lib.optionals stdenv.isDarwin [
        "-DMAC_CODESIGN_ID=OFF"
      ];

    # Fish’s test suite needs to be able to look up process information and send signals.
    sandboxProfile = lib.optionalString stdenv.isDarwin ''
      (allow mach-lookup mach-task-name)
      (allow signal (target children))
    '';

    preConfigure = "patchShebangs ./build_tools/git_version_gen.sh";

    # Required binaries during execution
    propagatedBuildInputs = [
      gnugrep
      gnused
      mandoc
      gettext
      man-db
    ];

    postInstall =
      ''
        sed -r "s|command grep|command ${gnugrep}/bin/grep|" \
            -i "$out/share/fish/functions/grep.fish"
        sed -i "s|mandoc|${mandoc}/bin/mandoc|"              \
               "$out/share/fish/functions/__fish_print_help.fish"
        sed -i "s|/usr/local/sbin /sbin /usr/sbin||"         \
               $out/share/fish/completions/{sudo.fish,doas.fish}
        sed -e "s| awk | ${gawk}/bin/awk |"                  \
            -i $out/share/fish/functions/{__fish_print_packages.fish,__fish_print_addresses.fish,__fish_describe_command.fish,__fish_complete_man.fish,__fish_complete_convert_options.fish} \
               $out/share/fish/completions/{cwebp,adb,ezjail-admin,grunt,helm,heroku,lsusb,make,p4,psql,rmmod,vim-addons}.fish

        sed -i "s|Popen(\['manpath'|Popen(\['${man-db}/bin/manpath'|" \
                "$out/share/fish/tools/create_manpage_completions.py"
        sed -i "s|command manpath|command ${man-db}/bin/manpath|"     \
                "$out/share/fish/functions/man.fish"

        sed -e "s|/usr/bin/getent|${getent}/bin/getent|" \
            -i $out/share/fish/functions/*.fish

        tee -a $out/share/fish/__fish_build_paths.fish < ${fishPreInitHooks}
      ''
      + optionalString usePython ''
        cat > $out/share/fish/functions/__fish_anypython.fish <<EOF
        function __fish_anypython
            echo ${python3.interpreter}
            return 0
        end
        EOF
      ''
      + optionalString useOperatingSystemEtc ''
        tee -a $out/etc/fish/config.fish < ${etcConfigAppendix}
      '';

    meta = with lib; {
      description = "Smart and user-friendly command line shell";
      homepage = "https://fishshell.com/";
      changelog = "https://github.com/fish-shell/fish-shell/blob/master/CHANGELOG.rst#fish-380-released-";
      license = licenses.gpl2Only;
      platforms = platforms.unix;
      maintainers = [maintainers.diniamo];
      mainProgram = "fish";
    };

    passthru.shellPath = "/bin/fish";
  })
