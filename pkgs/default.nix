{pkgs}: let
  mkPackage = path: pkgs.callPackage path {};
  mkMpvPackage = path: pkgs.mpvScripts.callPackage path {};
in {
  bencode-pretty = mkPackage ./bencode-pretty.nix;
  starship-nix3-shell = mkPackage ./starship-nix3-shell;

  mpvScripts = {
    SimpleUndo = mkMpvPackage ./mpvScripts/SimpleUndo.nix;
    skiptosilence = mkMpvPackage ./mpvScripts/skiptosilence.nix;
  };
}
