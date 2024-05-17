{pkgs}: let
  mkPackage = path: pkgs.callPackage path {};
  mkMpvPackage = path: pkgs.mpvScripts.callPackage path {};
in {
  bencode-pretty = mkPackage ./derivations/bencode-pretty.nix;

  mpvScripts = {
    SimpleUndo = mkMpvPackage ./derivations/mpvScripts/SimpleUndo.nix;
    skiptosilence = mkMpvPackage ./derivations/mpvScripts/skiptosilence.nix;
  };
}
