{
  libqalculate,
  fetchFromGitHub,
}:
libqalculate.overrideAttrs {
  version = "2024-10-22";

  src = fetchFromGitHub {
    owner = "Qalculate";
    repo = "libqalculate";
    rev = "d3035a023e47e60f9a3621083cae9a3fc15ab0c6";
    hash = "sha256-AIynupy5cBiZ8TzRCgV3w91+kTm8ZlY0w+6VGAArjWU=";
  };
}
