{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "2024-07-12";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "70496744dd9d99e00330a97c617ea6b9432a0276";
    hash = "sha256-8b4CY1MlTIe8iF711nzdE9QWdAS7nkNIvjCDvxvwLmY=";
  };
}
