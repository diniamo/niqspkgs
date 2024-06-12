{
  description = "A collection of my self-maintained nix derivations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default-linux";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      imports = [./pkgs];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };

      flake.nixConfig = {
        extra-substituters = ["https://cache.garnix.io"];
        extra-trusted-public-keys = ["cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="];
      };
    };
}
