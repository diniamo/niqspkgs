{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "4.3-unstable-2025-06-25";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "3a45a409058157701d2586340847779e439c7599";
    hash = "sha256-0MiIJVX1GKyvoGw1+DGVE1gJq/6sJiA79L16YF4USiQ=";
  };
}
