{fish}:
(fish.override {useOperatingSystemEtc = false;}).overrideAttrs (prev: {
  patches = (prev.patches or []) ++ [./patches/fish-prompt-fix.patch];
})
