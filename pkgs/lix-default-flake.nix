{lix}:
lix.overrideAttrs (prev: {
  pname = "lix-default-flake";

  patches = (prev.patches or []) ++ [./patches/lix-default-flake.patch];
})
