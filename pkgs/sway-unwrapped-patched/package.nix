{sway-unwrapped, wlroots, fetchFromGitLab, fetchFromGitHub}: (sway-unwrapped.override {
  wlroots = wlroots.overrideAttrs {
    version = "0-unstable-213bd88";
    
    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = "8e36040e";
      hash = "sha256-NSr3TehRRuD4djp4IlF7RjmXIdyyZAFql3V1cHPUl8g=";
    };
  };
}).overrideAttrs {
  version = "0-unstable-05e895c";
  
  src = fetchFromGitHub {
    owner = "swaywm";
    repo = "sway";
    rev = "05e895c4638293a6bfe594ff0cae4eaab63b740e";
    hash = "sha256-RiPK3pKJoZHUmeLmhSFp26ehlqv99RIUxIFSunmvv+U=";
  };
}
