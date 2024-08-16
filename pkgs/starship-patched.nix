{starship}:
starship.overrideAttrs (prev: {
  pname = "starship-patched";

  patches = (prev.patches or []) ++ [./patches/starship-nix3-shell.patch];
})
