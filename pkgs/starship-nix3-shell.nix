{starship}:
starship.overrideAttrs (prev: {
  pname = "starship-nix3-shell";

  patches = (prev.patches or []) ++ [./patches/starship-nix3-shell.patch];
})
