{
  stdenv,
  fetchFromGitHub,
  pkgconf,
  dbus
}: stdenv.mkDerivation {
  pname = "unified-inhibit";
  version = "0-unstable-c94e953";

  src = fetchFromGitHub {
    owner = "wentam";
    repo = "unified-inhibit";
    rev = "c94e953ca3c8a1ec0d850900aee255ebcdb9f404";
    hash = "sha256-TmGXOuO8kCDOr5Bzdk9N/6hbEr3n3tqgF/SWwn2cgio=";
  };

  nativeBuildInputs = [ pkgconf ];
  buildInputs = [ dbus ];
  makeFlags = [ "prefix=$(out)" "X11=0" ];

  meta.mainProgram = "uinhibitd";
}
