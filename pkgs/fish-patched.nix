{fish}:
(fish.override {useOperatingSystemEtc = false;}).overrideAttrs (prev: {
  pname = "fish-patched";

  patches = (prev.patches or []) ++ [./patches/fish-prompt-fix.patch];
})
