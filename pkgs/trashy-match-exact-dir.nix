{trashy}:
trashy.overrideAttrs (prev: {
  name = "trashy-match-exact-dir";
  patches = (prev.patches or []) ++ [./patches/trashy-match-exact-dir.patch];
})
