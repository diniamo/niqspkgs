{system}: let
  flake = builtins.getFlake "github:lix-project/lix/f2e7f8bab875809e8b489e1e5a7aa8572bb4bc13";

  package = flake.packages.${system}.default;
in
  package.overrideAttrs (prev: {
    pname = "lix-patched";

    patches =
      (prev.patches or [])
      ++ [
        ./patches/lix-default-flake.patch
        ./patches/lix-nix3-shell.patch
      ];
  })
