{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  systemd,
  dbus,
}: stdenv.mkDerivation {
  pname = "org.freedesktop.FileManager1.common";
  version = "0-unstable-7f51612";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "org.freedesktop.FileManager1.common";
    rev = "7f516129ac71be409dc415421859de68c1a2ed0e";
    hash = "sha256-FCmNqz8JaP6XUaJOoWw5Lfls3ThdY+Yv2kRdk8XIRic=";
  };

  patches = [ ./wrapper-argument.patch ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];
  buildInputs = [
    systemd
    dbus
  ];
}
