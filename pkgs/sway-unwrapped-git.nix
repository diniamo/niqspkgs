{ sway-unwrapped, wlroots, fetchFromGitLab, fetchFromGitHub }: (sway-unwrapped.override {
  wlroots = wlroots.overrideAttrs {
    version = "0-unstable-48bd183";
    
    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = "48bd1831feff89ac94aacc2218601c2b569ef70c";
      hash = "sha256-Y9wJQ2hhUH/F6p/Fsi+cwjVl8dD7YKnYNMZeTYwAMog=";
    };
  };
}).overrideAttrs {
  version = "0-unstable-56f2db0";
  
  src = fetchFromGitHub {
    owner = "swaywm";
    repo = "sway";
    rev = "56f2db062daa64a0df77a83823d85fec7c3a9f46";
    hash = "sha256-jwV8dGsALPSAeWXJLBgIXERbHp7POduaFE1rPU2ofeg=";
  };
}
