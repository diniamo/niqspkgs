{
  satty,
  fetchFromGitHub,
}:
satty.overrideAttrs {
  src = fetchFromGitHub {
    owner = "gabm";
    repo = "Satty";
    rev = "84e6b1b3cbc8382d50d43971e5f42445c1eaff90";
    hash = "sha256-x1QyM4wq9T1gFZVsTqHIRRJPPHdoSNNDjkwW5RrN7DU=";
  };
}
