{
  stdenv,
  lib,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  inih,
  libxkbcommon,
  pango,
  icu75,
  wayland,
  egl-wayland,
  libGL,
  xorg,
  libGLU,
  cmocka,
  libtiff,
  libpng,
  libjpeg_turbo,
  librsvg,
  libnsgif,
  libheif,
  libjxl,
  asciidoc,
  waylandSupport ? true,
  x11Support ? false,
  tiffSupport ? true,
  pngSupport ? true,
  jpegSupport ? true,
  svgSupport ? true,
  gifSupport ? true,
  heifSupport ? true,
  jpegxlSupport ? true
}:
assert lib.assertMsg (waylandSupport || x11Support) "imv: at least one of waylandSupport and x11Support must be set";
let
  inherit (lib) optionals optional optionalString;

  windowSystem =
    if waylandSupport && x11Support then "all" else
    if waylandSupport then "wayland" else
    "x11";
in stdenv.mkDerivation rec {
  pname = "imv";
  version = "4.5.0-unstable-2025-08-06";

  src = fetchFromGitHub {
    owner = "diniamo";
    repo = "imv";
    rev = "5c109f42683b1c48abd9a2b2d768f3d9e146b155";
    hash = "sha256-0W2VmKBPeSN3wyCnT5Txo461gudQAbco0OE3LM9tctk=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    asciidoc
  ];

  buildInputs = [
    inih
    libxkbcommon
    pango
    icu75
  ] ++ optionals waylandSupport [
    wayland
    egl-wayland
    libGL
  ] ++ optionals x11Support [
    xorg.libX11
    xorg.libxcb
    libGLU
  ] ++ optional tiffSupport libtiff
  ++ optional pngSupport libpng
  ++ optional jpegSupport libjpeg_turbo
  ++ optional svgSupport librsvg
  ++ optional gifSupport libnsgif
  ++ optional heifSupport libheif
  ++ optional jpegxlSupport libjxl;

  checkInputs = [ cmocka ];

  outputs = [
    "out"
    "man"
  ];

  mesonBuildType = "release";
  mesonAutoFeatures = "auto";
  mesonFlags = [
    "-Dwindow_system=${windowSystem}"
    "-Dman=enabled"
    "-Dtest=enabled"
  ];

  postFixup = optionalString (waylandSupport && x11Support) ''
    substituteInPlace "$out/bin/imv" \
      --replace-fail "imv-wayland" "$out/bin/imv-wayland" \
      --replace-fail "imv-x11" "$out/bin/imv-x11"
  '';

  doCheck = true;

  meta = {
    description = "Command line image viewer for tiling window managers";
    homepage = "https://github.com/diniamo/imv";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.diniamo ];
    platforms = lib.platforms.unix;
    mainProgram = "imv";
  };
}
