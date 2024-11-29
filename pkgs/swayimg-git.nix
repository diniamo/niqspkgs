{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "2024-11-29";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "e8f421ba55f91d149e9bd46b74e11c3f234610cb";
    hash = "sha256-SXxLmpGMHViqtZHoqChnmV24kLiGlh3bximZ78BaqoI=";
  };
}
