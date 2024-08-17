{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "2024-08-17";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "8d37527234253de38f619cf09a7bd944ff2173b1";
    hash = "sha256-SVjzse/QjLW8+wkdqtRARLn0/301+l+pnaxusbTXjhY=";
  };
}
