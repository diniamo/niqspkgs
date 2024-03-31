{
  description = "A collection of my self-maintained nix derivations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        mkPackage = path: pkgs.callPackage path {};
        mkMpvScript = path: pkgs.mpvScripts.callPackage path {};
      in {
        formatter = pkgs.alejandra;

        packages = {
          bencode-pretty = mkPackage ./pkgs/bencode-pretty.nix;

          SimpleUndo = mkMpvScript ./pkgs/mpvScripts/SimpleUndo.nix;
          skiptosilence = mkMpvScript ./pkgs/mpvScripts/skiptosilence.nix;
        };
      };
    };
}
