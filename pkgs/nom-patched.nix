{
  nix-output-monitor,
  lib,
}: let
  icons = {
    "↑" = "f062";
    "↓" = "f063";
    "⏱" = "f520";
    "⏵" = "f04b";
    "✔" = "f00c";
    "⏸" = "f04c";
    "⚠" = "f071";
    "∅" = "f1da";
    "∑" = "f04a0";
  };
in
  nix-output-monitor.overrideAttrs {
    pname = "nix-output-monitor-patched";

    postPatch = ''
      substituteInPlace lib/NOM/Print.hs \
        ${lib.concatLines (lib.mapAttrsToList (old: new: "--replace-fail '${old}' '\\x${new}' \\") icons)}

      substituteInPlace lib/NOM/Print/Tree.hs --replace-fail '┌' '╭'
    '';
  }
