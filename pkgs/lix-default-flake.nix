{lix}:
lix.overrideAttrs (prev: {
  patches = (prev.patches or []) ++ [./patches/lix-default-flake.patch];
})
