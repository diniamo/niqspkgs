{sway-unwrapped, wlroots, fetchFromGitLab, fetchFromGitHub}: (sway-unwrapped.override {
  wlroots = wlroots.overrideAttrs {
    version = "0-unstable-a30c102";
    
    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = "a30c1021638b08654c3b6528a25da4b50ad6d6bf";
      hash = "sha256-7B6BfcjiOEhbXXuLoiy7NYyzX5KZDZJ77oU6QW0WmJI=";
    };
  };
}).overrideAttrs {
  version = "0-unstable-170c9c9";
  
  src = fetchFromGitHub {
    owner = "swaywm";
    repo = "sway";
    rev = "170c9c9525f54e8c1ba03847d5f9b01fc24b8c89";
    hash = "sha256-ziKsVin8Ze00ZkI4c6TL9sZgNCkdnow75KXixkuhCpM=";
  };
  patches = [ ./revert-idle-inhibit-no-invisible.patch ];
}
