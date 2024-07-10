{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "2024-07-08";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "2f33c4c869139d234e81c535334cfc526ee9b481";
    hash = "sha256-YmiT3W7VrTzH9sK3H2ownUHRiv8GeFbEqu1V/nJGyPs=";
  };
}
