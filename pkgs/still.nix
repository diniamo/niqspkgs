{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  wayland-scanner,
  scdoc,
  wayland,
  wayland-protocols,
  pixman
}: stdenv.mkDerivation {
  pname = "still";
  version = "0.0.8";

  src = fetchFromGitHub {
    owner = "faergeek";
    repo = "still";
    rev = "v0.0.8";
    hash = "sha256-Ld93xCTgxK4NI4aja6VBYdT9YJHDtoHuiy0c18ACv6M=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wayland-scanner
    scdoc
  ];
  buildInputs = [
    wayland
    wayland-protocols
    pixman
  ];

  mesonBuildType = "release";

  meta.mainProgram = "still";
}
