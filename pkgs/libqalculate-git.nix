{
  libqalculate,
  fetchFromGitHub,
}:
libqalculate.overrideAttrs {
  version = "2024-10-18";

  src = fetchFromGitHub {
    owner = "Qalculate";
    repo = "libqalculate";
    rev = "9cf6734f015c8c44feda9d3172e286ef1ce412e4";
    hash = "sha256-AYfYhJx3mW8Nno2BKVYtNRu+AHMip2H3mTUXSLftEyQ=";
  };
}
