{sway-unwrapped, wlroots, fetchFromGitLab, fetchFromGitHub}: (sway-unwrapped.override {
  wlroots = wlroots.overrideAttrs {
    version = "0-unstable-a08acfc";
    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = "a08acfcee0261ae9b084c217dd70dd52eea2904a";
      hash = "sha256-1KK25FnbYeC29IJLDCx1hDj/3cMBSTq36dQvPVrznF8=";
    };
  };
}).overrideAttrs {
  version = "0-unstable-7e7994d";
  src = fetchFromGitHub {
    owner = "swaywm";
    repo = "sway";
    rev = "7e7994dbb2a2c04f55b3c74eb61577c51e9a43ae";
    hash = "sha256-Ba9Ed5urZ8ll52wdqMqBjCBBP2IplriOZ+0rW9vOzzk=";
  };
}
