{lix}:
lix.overrideAttrs (prev: {
  pname = "lix-patched";

  patches =
    (prev.patches or [])
    ++ [
      ./patches/lix-default-flake.patch
      ./patches/lix-nix3-shell.patch
    ];
})
