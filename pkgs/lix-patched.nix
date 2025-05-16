{inputs'}: inputs'.lix.packages.default.overrideAttrs (prev: {
  pname = "lix-patched";

  patches = (prev.patches or []) ++ [./patches/lix-default-flake.patch];

  doCheck = false;
})
