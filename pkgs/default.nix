{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (pkgs) callPackage;

    mkPackage = path: callPackage path {};
    mkMpvScript = path: pkgs.mpvScripts.callPackage path {};

    packages = {
      swayimg-git = mkPackage ./swayimg-git.nix;
      lix-patched = callPackage ./lix-patched.nix {inherit inputs;};
      comma-patched = mkPackage ./comma-patched.nix;
      nom-patched = mkPackage ./nom-patched.nix;
      nh-patched = callPackage ./nh-patched.nix {inherit self;};
      fish-patched = mkPackage ./fish-patched.nix;
      bibata-hyprcursor = mkPackage ./bibata-hyprcursor;
      file-roller-gtk3 = mkPackage ./file-roller-gtk3.nix;
      git-clean = mkPackage ./git-clean.nix;
      odin-patched = mkPackage ./odin-patched.nix;
      xdccget = mkPackage ./xdccget.nix;
      my-cookies = mkPackage ./my-cookies.nix;

      # mpvScripts
      simple-undo = mkMpvScript ./mpvScripts/simple-undo.nix;
      skip-to-silence = mkMpvScript ./mpvScripts/skip-to-silence.nix;
    };
  in {
    # legacyPackages complicates things a lot, there is no point
    inherit packages;
  };
}
