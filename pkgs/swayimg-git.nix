{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "f2bbe7535d80c55e9b743306f22bc22530b78582";
    hash = "sha256-FQshKPtpbJ2TgA/hJRLYK+QUTX6YarV8nfZGujkmxao=";
  };
}
