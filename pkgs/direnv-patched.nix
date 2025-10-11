{ direnv, fetchFromGitHub }: direnv.overrideAttrs {
  version = "2.37.1-unstable-c0ce70d";

  src = fetchFromGitHub {
    owner = "diniamo";
    repo = "direnv";
    rev = "c0ce70d6af65726fe08520d8dbb48f8d2ba62e29";
    hash = "sha256-3fzLq8dvvmZGAMPf5ONOw/9ZIuQjN4euogQ++voSd+E=";
  };
}
