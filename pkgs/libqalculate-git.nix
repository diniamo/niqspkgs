{
  libqalculate,
  fetchFromGitHub,
}:
libqalculate.overrideAttrs {
  version = "2024-10-19";

  src = fetchFromGitHub {
    owner = "Qalculate";
    repo = "libqalculate";
    rev = "e74ef3b6227fd2d7836796c819fa47106cf9bccc";
    hash = "sha256-9mKRecFrs0fs9cw8L4tX5q+fkHn4qd9ic95ga+EMhw4=";
  };
}
