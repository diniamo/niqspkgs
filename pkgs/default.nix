{pkgs}: let
  mkPackage = path: pkgs.callPackage path {};
  mkMpvPackage = path: pkgs.mpvScripts.callPackage path {};
in {
  bencode-pretty = mkPackage ./bencode-pretty.nix;

  mpvScripts = {
    SimpleUndo = mkMpvPackage ./mpvScripts/SimpleUndo.nix;
    skiptosilence = mkMpvPackage ./mpvScripts/skiptosilence.nix;
  };
}
