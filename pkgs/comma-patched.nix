{
  comma,
  fetchFromGitHub,
  rustPlatform
}: let
  final = comma.overrideAttrs (prev: {
    pname = "comma-patched";
    version = "2024-11-15";

    src = fetchFromGitHub {
      owner = "nix-community";
      repo = "comma";
      rev = "ae61728cb99fc680bae716660532d11c017ef956";
      hash = "sha256-UPqArYDOWMe8Bhs7tKVSdtvYbAZY4u0ZV85WfYQ16vY=";
    };

    cargoDeps = rustPlatform.importCargoLock {
      lockFile = "${final.src}/Cargo.lock";
    };
  });
in final
