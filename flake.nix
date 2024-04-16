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
        mkMpvPackage = path: pkgs.mpvScripts.callPackage path {};
      in {
        formatter = pkgs.alejandra;

        legacyPackages = {
          bencode-pretty = mkPackage ./pkgs/bencode-pretty.nix;

          mpvScripts = {
            SimpleUndo = mkMpvPackage ./pkgs/mpvScripts/simple-undo.nix;
            skiptosilence = mkMpvPackage ./pkgs/mpvScripts/skip-to-silence.nix;
          };
        };
      };
    };
}
