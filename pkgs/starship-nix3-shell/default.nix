{starship}:
starship.overrideAttrs (prev: {
  patches = (prev.patches or []) ++ [./nix3-shell.patch];
})
