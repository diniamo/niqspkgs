{starship}:
starship.overrideAttrs (prev: {
  patches = (prev.patches or []) ++ [./patches/starship-nix3-shell.patch];
})
