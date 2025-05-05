{
  inputs,
  system,
}: inputs.lix.packages.${system}.default.overrideAttrs (prev: {
  pname = "lix-patched";

  patches = (prev.patches or []) ++ [./patches/lix-default-flake.patch];

  doCheck = false;
})
