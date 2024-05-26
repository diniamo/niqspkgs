{
  pkgs,
  lib,
  stdenvNoCC,
  nodejs,
}: let
  nodePackages = final: import ./composition.nix {
    inherit pkgs nodejs;
    inherit (stdenvNoCC.hostPlatform) system;
  };

  mainProgramOverrides = final: prev:
    builtins.mapAttrs (
      pkgName: mainProgram:
        prev.${pkgName}.override (oldAttrs: {
          meta = oldAttrs.meta // {inherit mainProgram;};
        })
    ) (import ./main-programs.nix);

  extensions = lib.composeExtensions mainProgramOverrides (import ./overrides.nix {inherit pkgs;});
in lib.fix (lib.extends extensions nodePackages)
