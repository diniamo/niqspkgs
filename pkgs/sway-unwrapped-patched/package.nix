{sway-unwrapped, wlroots, fetchFromGitLab, fetchFromGitHub}: (sway-unwrapped.override {
  wlroots = wlroots.overrideAttrs {
    version = "0-unstable-8c7041c";
    
    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = "8c7041c4e842c9fb029a6371eb53f73aa98e7b31";
      hash = "sha256-JXbtW7qcuX1Nvq4KBRRVx01IZA/T1LD7An5tKrNFIBg=";
    };
  };
}).overrideAttrs {
  version = "0-unstable-3d6b9a2";
  
  src = fetchFromGitHub {
    owner = "swaywm";
    repo = "sway";
    rev = "3d6b9a28480a398e3af869d4051181f98a042022";
    hash = "sha256-Vq8wb+MqIpevbPwhvdEpwWB3XOth2VCnbEUBgUt5sBQ=";
  };
  patches = [ ./revert-idle-inhibit-no-invisible.patch ];
}
