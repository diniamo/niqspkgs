{pkgs}: let
  mkPackage = path: pkgs.callPackage path {};
  mkMpvPackage = path: pkgs.mpvScripts.callPackage path {};
in {
  bencode-pretty = mkPackage ./bencode-pretty.nix;
  starship-nix3-shell = mkPackage ./starship-nix3-shell.nix;
  alacritty-sixel = mkPackage ./alacritty-sixel.nix;

  # Relies on callPackage currently
  nodePackages = {
    cbmp = mkPackage ./nodePackages/cbmp;
  };
  mpvScripts = {
    simple-undo = mkMpvPackage ./mpvScripts/simple-undo.nix;
    skip-to-silence = mkMpvPackage ./mpvScripts/skip-to-silence.nix;
  };
}
