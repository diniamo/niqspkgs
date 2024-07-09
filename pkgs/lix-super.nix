{lix}:
lix.overrideAttrs (prev: {
  pname = "lix-super";

  patches =
    (prev.patches or [])
    ++ [
      ./patches/lix-default-flake.patch
      ./patches/lix-nix3-shell.patch
    ];
})
