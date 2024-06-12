{
  perSystem = {pkgs, ...}: let
    mkPackage = path: pkgs.callPackage path {};
    mkMpvPackage = path: pkgs.mpvScripts.callPackage path {};
  in {
    # garnix doesn't support legacyPackages
    packages = {
      bencode-pretty = mkPackage ./bencode-pretty.nix;
      starship-nix3-shell = mkPackage ./starship-nix3-shell.nix;
      alacritty-sixel = mkPackage ./alacritty-sixel.nix;
      swayimg-git = mkPackage ./swayimg-git.nix;

      # nodePackages
      cbmp = mkPackage ./nodePackages/cbmp;

      # mpvScripts
      simple-undo = mkMpvPackage ./mpvScripts/simple-undo.nix;
      skip-to-silence = mkMpvPackage ./mpvScripts/skip-to-silence.nix;
    };
  };
}
