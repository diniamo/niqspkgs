{
  stdenv,
  fetchFromGitLab,
  which,
  pkg-config,
  wayland-scanner,
  wayland,
  wayland-protocols,
  libxkbcommon,
  pixman,
  libevdev,
  libscfg,
  libbsd
}: stdenv.mkDerivation {
  pname = "tarazed";
  version = "0-unstable-05fa92a";

  src = fetchFromGitLab {
    domain = "gitlab.gwdg.de";
    owner = "leonhenrik.plickat";
    repo = "tarazed";
    rev = "05fa92ab73c3db7533b01ce3ce89907e13a8a672";
    hash = "sha256-EMYdZKwAu9GtEs0J6xI14+iU4RlXf2qfBNkEVcY7xfc=";
  };

  nativeBuildInputs = [
    which
    pkg-config
    wayland-scanner
  ];
  buildInputs = [
    wayland
    wayland-protocols
    libxkbcommon
    pixman
    libevdev
    libscfg
    libbsd
  ];

  buildPhase = ''
    runHook preBuild
    make release
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    install -Dm755 tarazed $out/bin/tarazed
    runHook postInstall
  '';

  meta.mainProgram = "tarazed";
}
