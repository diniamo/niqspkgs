{
  river-classic,
  libxkbcommon,
  fetchFromGitHub,
  fetchFromGitea,
  callPackage,
  lib
}: (river-classic.override {
  libxkbcommon = libxkbcommon.overrideAttrs {
    version = "1.13.1";

    src = fetchFromGitHub {
      owner = "xkbcommon";
      repo = "libxkbcommon";
      tag = "xkbcommon-1.13.1";
      hash = "sha256-wUsxsM0xXTg7nbvFMXrrnHherOepj0YI77eferjRgJA=";
    };

    patches = [];
    doCheck = false;
  };
}).overrideAttrs {
  pname = "river";
  version = "0.4.0-unstable-a5a9dce";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "river";
    repo = "river";
    rev = "a5a9dcedf482d3d1491a32aa9c5d6b9d2c8a6f61";
    hash = "sha256-YAgV4QHfn2FZnHmQWWSDfO2A7d4tgXuydJtWqbJnkwQ=";
  };

  deps = callPackage ./deps.nix {};

  postInstall = "install contrib/river.desktop -Dt $out/share/wayland-sessions";
  doInstallCheck = false;

  meta = {
    homepage = "https://codeberg.org/river/river";
    longDescription = null;
    changelog = null;
    maintainers = [ lib.maintainers.diniamo ];
  };
}
