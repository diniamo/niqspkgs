{
  alacritty,
  fetchFromGitHub,
}:
alacritty.overrideAttrs (old: rec {
  pname = "alacritty-sixel";

  src = fetchFromGitHub {
    owner = "ayosec";
    repo = "alacritty";
    rev = "e0d84e48e1a9705219a1a3074e087d3f015c4144";
    hash = "sha256-yajypRvpdy6Tjm5pBaEjOq0ykulEZtujklTzYrBoIFQ=";
  };

  cargoDeps = old.cargoDeps.overrideAttrs {
    inherit src;
    outputHash = "sha256-F9NiVbTIVOWUXnHtIUvxlZ5zvGtgz/AAyAhyS4w9f9I=";
  };
})
