{
  stdenv,
  fetchFromGitHub,
  self',
  openhmd-thaytan ? self'.packages.openhmd-thaytan,
  meson,
  ninja,
  pkg-config
}: stdenv.mkDerivation {
  pname = "SteamVR-OpenHMD";
  version = "0-unstable-19dabd2";

  src = fetchFromGitHub {
    owner = "thaytan";
    repo = "SteamVR-OpenHMD";
    rev = "19dabd2775ce28fc693824c176844c9adffa437d";
    hash = "sha256-sRhVLDQYBgBJvQ/itVcVPFxahm8LCxzyeR66dGTeDQ4=";
  };
  patches = [ ./no-subproject.patch ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];
  buildInputs = [
    openhmd-thaytan
  ];

  installPhase = ''
    runHook preInstall

    install -Dt $out/bin/linux64 driver_openhmd.so
    cp -r $src/{resources,driver.vrdrivermanifest} $out

    runHook postInstall
  '';
}
