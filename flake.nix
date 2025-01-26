{
  description = "A collection of my self-maintained nix derivations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default-linux";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    lix = {
      url = "github:lix-project/lix";
      inputs.nixpkgs.follows = "nixpkgs";
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
    };

  nixConfig = {
    extra-substituters = ["https://niqspkgs.cachix.org"];
    extra-trusted-public-keys = ["niqspkgs.cachix.org-1:3lcNxXkj8BLrK77NK9ZTjk0fxHuSZrr5sKE6Avjb6PI="];
  };
}
