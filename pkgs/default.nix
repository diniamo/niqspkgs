{
  perSystem = {pkgs, ...}: let
    mkPackage = path: pkgs.callPackage path {};
    mkMpvScript = path: pkgs.mpvScripts.callPackage path {};
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
      simple-undo = mkMpvScript ./mpvScripts/simple-undo.nix;
      skip-to-silence = mkMpvScript ./mpvScripts/skip-to-silence.nix;
    };
  };
}
