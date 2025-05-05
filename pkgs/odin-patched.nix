{odin}: odin.overrideAttrs (prev: {
  pname = "odin-patched";
  
  patches = (prev.patches or []) ++ [
    ./patches/odin-system-raylib.patch
  ];

  postPatch = prev.postPatch + ''
    rm -r vendor/raylib/{linux,macos,macos-arm64,wasm,windows}
  '';
})
