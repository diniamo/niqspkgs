{inputs'}: inputs'.lix.packages.default.overrideAttrs (prev: {
  pname = "lix-patched";

  patches = (prev.patches or []) ++ [./default-flake.patch];

  doCheck = false;
})
