{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "2024-07-11";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "c78d785128880dd736ebd175f18f32dcd928b2e2";
    hash = "sha256-RIYpKQvZW+2mehnGhSjTHmwt6MtGlskMP0zWIJMWmCA=";
  };
}
