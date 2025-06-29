{
  description = "A collection of my self-maintained nix derivations";

  nixConfig = {
    extra-substituters = ["https://niqspkgs.cachix.org"];
    extra-trusted-public-keys = ["niqspkgs.cachix.org-1:3lcNxXkj8BLrK77NK9ZTjk0fxHuSZrr5sKE6Avjb6PI="];
  };

  outputs = inputs @ {
    flake-parts,
    systems,
    ...
  }: flake-parts.lib.mkFlake {inherit inputs;} {
    systems = import systems;

    perSystem = {pkgs, lib, inputs', self', ...}: {
      formatter = pkgs.alejandra;
      
      packages = let
        inherit (lib) packagesFromDirectoryRecursive callPackageWith;
        inherit (builtins) listToAttrs;

        extraArguments = { inherit inputs' self'; };
        packages = packagesFromDirectoryRecursive {
          callPackage = callPackageWith (pkgs // extraArguments);
          directory = ./pkgs;
        };

        mpvScripts = packagesFromDirectoryRecursive {
          callPackage = callPackageWith (pkgs // pkgs.mpvScripts // extraArguments);
          directory = ./mpvScripts;
        };

        fromInputs = [
          "watt"
          "flint"
          "wiremix"
          "dsync"
        ];
        inherited = listToAttrs (map (input: {
          name = input;
          value = inputs'.${input}.packages.default;
        }) fromInputs);
      in packages // mpvScripts // inherited;
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default-linux";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nq = {
      url = "github:diniamo/nq";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
      };
    };
    watt = {
      url = "github:NotAShelf/watt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flint = {
      url = "github:NotAShelf/flint";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wiremix = {
      url = "github:tsowell/wiremix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    dsync = {
      url = "github:diniamo/dsync";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
  };
}
