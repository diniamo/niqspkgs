{sway-unwrapped, wlroots, fetchFromGitLab, fetchFromGitHub}: (sway-unwrapped.override {
  wlroots = wlroots.overrideAttrs {
    version = "0-unstable-afe427d";
    
    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = "afe427d149e701fb244152e1b44ebaa34e3a4cb0";
      hash = "sha256-O/jNW+MsdFfILaYgFYdsIYzuEyEEWiF4WUlHH98v3rQ=";
    };
  };
}).overrideAttrs {
  version = "0-unstable-6816b51";
  
  src = fetchFromGitHub {
    owner = "swaywm";
    repo = "sway";
    rev = "6816b51c86846afc5eaa1dea2541410058347a6e";
    hash = "sha256-URr3o5b6C+MQsfI25M2FAb2ybaRfJ6tSb+55Oaask4E=";
  };
  patches = [ ./revert-idle-inhibit-no-invisible.patch ];
}
