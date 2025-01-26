{
  inputs,
  system,
}: let
  package = inputs.lix.packages.${system}.default;
in
  package.overrideAttrs (prev: {
    pname = "lix-patched";

    patches =
      (prev.patches or [])
      ++ [
        ./patches/lix-fix-nixconfig.patch
        ./patches/lix-default-flake.patch
        ./patches/lix-nix3-shell.patch
      ];

    doCheck = false;
  })
