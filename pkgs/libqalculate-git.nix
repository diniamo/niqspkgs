{
  libqalculate,
  fetchFromGitHub,
}:
libqalculate.overrideAttrs {
  version = "2024-10-21";

  src = fetchFromGitHub {
    owner = "Qalculate";
    repo = "libqalculate";
    rev = "52037dd0613053b44c7178710e35d864dc84b8c8";
    hash = "sha256-SVbPXJEbrXBS6jQqJeAI380ZViKKuUDhUP98BtgzQSQ=";
  };
}
