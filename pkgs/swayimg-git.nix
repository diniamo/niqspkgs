{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "2024-09-15";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "fecd704833b996e02b8029235a5d0a25a85a28e5";
    hash = "sha256-LFWvKJV8pf4u29rFQdUYf9i2QUeqrEKLxva0rqFPY2A=";
  };
}
