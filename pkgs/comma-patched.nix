{
  comma,
  fetchFromGitHub,
}:
comma.overrideAttrs (prev: rec {
  pname = "comma-patched";
  version = "2024-11-15";

  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "comma";
    rev = "ae61728cb99fc680bae716660532d11c017ef956";
    hash = "sha256-UPqArYDOWMe8Bhs7tKVSdtvYbAZY4u0ZV85WfYQ16vY=";
  };

  cargoDeps = prev.cargoDeps.overrideAttrs {
    inherit src;
    outputHash = "sha256-poQDzC5DLkwLMwt5ieZCSyrQIKkuYq6hu6cj7lcDb4c=";
  };
})
