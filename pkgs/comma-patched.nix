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
    hash = "sha256-mtlW9wDZyISjMYZeVSUGDbBCEzu4+2neDx3fD9rj0To=";
  };

  cargoDeps = prev.cargoDeps.overrideAttrs {
    inherit src;
    outputHash = "sha256-gjChTXqQAZiTlaAR8ibLuMBXTFCcaZCA2riLZa5JoRU=";
  };
})
