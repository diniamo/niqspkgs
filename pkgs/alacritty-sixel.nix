{
  alacritty,
  fetchFromGitHub,
}:
alacritty.overrideAttrs (old: rec {
  pname = "alacritty-sixel";
  version = "2024-10-24";

  src = fetchFromGitHub {
    owner = "ayosec";
    repo = "alacritty";
    rev = "ecf278007a5fe024fe624c7dea4664239d81f44b";
    hash = "sha256-7ujUi8QXzJdy8WpSXS8BYtyvWzlwEfYCg7/WdKF44bs=";
  };

  cargoDeps = old.cargoDeps.overrideAttrs {
    inherit src;
    outputHash = "sha256-iq6RNws725/bGgLGIcusJuh9AIiSZ6uXTZkLkYk8RG8=";
  };
})
