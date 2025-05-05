{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (pkgs.lib) callPackageWith;

    extraArguments = { inherit self inputs; };
    mkPackage = path: callPackageWith (pkgs // extraArguments) path {};
    mkMpvScript = path: callPackageWith (pkgs // pkgs.mpvScripts // extraArguments) path {};

    packages = {
      swayimg-git = mkPackage ./swayimg-git.nix;
      lix-patched = mkPackage ./lix-patched.nix;
      comma-patched = mkPackage ./comma-patched.nix;
      nom-patched = mkPackage ./nom-patched.nix;
      fish-patched = mkPackage ./fish-patched.nix;
      bibata-hyprcursor = mkPackage ./bibata-hyprcursor;
      file-roller-gtk3 = mkPackage ./file-roller-gtk3.nix;
      git-clean = mkPackage ./git-clean.nix;
      odin-patched = mkPackage ./odin-patched.nix;
      xdccget = mkPackage ./xdccget.nix;
      my-cookies = mkPackage ./my-cookies.nix;
      rebuild-patched = mkPackage ./rebuild-patched.nix;

      # mpvScripts
      simple-undo = mkMpvScript ./mpvScripts/simple-undo.nix;
      skip-to-silence = mkMpvScript ./mpvScripts/skip-to-silence.nix;
      m-x = mkMpvScript ./mpvScripts/m-x.nix;
    };
  in {
    # legacyPackages complicates things a lot, there is no point
    inherit packages;
  };
}
