{
  comma,
  fetchFromGitHub,
}:
comma.overrideAttrs (prev: rec {
  pname = "comma-patched";

  src = fetchFromGitHub {
    owner = "diniamo";
    repo = "comma";
    rev = "cache-choices-sensible-print";
    hash = "sha256-nFRQ2K3Tx3lrimh3Rfn9wXK8Cw5rexL4BEYlYFp95Pc=";
  };

  cargoDeps = prev.cargoDeps.overrideAttrs {
    inherit src;
    outputHash = "sha256-RPLkVqQFVVAyw5J1jaBRPx8zOEA5Mwzj1Z+dMIpQwMo=";
  };
})
