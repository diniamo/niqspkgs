{
  alacritty,
  fetchFromGitHub,
}:
alacritty.overrideAttrs (old: rec {
  pname = "alacritty-sixel";

  src = fetchFromGitHub {
    owner = "ayosec";
    repo = "alacritty";
    rev = "6c4910fd20c7bab08b3bcee00eed4b5e4b37ef08";
    hash = "sha256-84rdjQzWNupN5dJsK6Txfl+EARXmkMIQ4TyfjIP1hTE=";
  };

  cargoDeps = old.cargoDeps.overrideAttrs {
    inherit src;
    outputHash = "sha256-F9NiVbTIVOWUXnHtIUvxlZ5zvGtgz/AAyAhyS4w9f9I=";
  };
})
