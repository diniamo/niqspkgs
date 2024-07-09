{
  swayimg,
  fetchFromGitHub,
}:
swayimg.overrideAttrs {
  version = "2024-07-08";

  src = fetchFromGitHub {
    owner = "artemsen";
    repo = "swayimg";
    rev = "a8cfb977355e7cd0cf97d1ad8b01fafc6e8236f2";
    hash = "sha256-C4fB7gQD0NLojW8Yfcm5WS/kFMONCtkKFd1WMpK+4bw=";
  };
}
