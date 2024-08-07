{
  coreutils-full,
  fetchpatch,
}:
coreutils-full.overrideAttrs (prev: {
  pname = "coreutils-full-advcpmv";

  patches =
    (prev.patches or [])
    ++ [
      (fetchpatch {
        url = "https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.9-${coreutils-full.version}.patch";
        hash = "sha256-LRfb4heZlAUKiXl/hC/HgoqeGMxCt8ruBYZUrbzSH+Y=";
      })
    ];
})
