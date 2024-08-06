{
  coreutils,
  fetchpatch,
}:
coreutils.overrideAttrs (prev: {
  pname = "coreutils-advcpmv";

  patches =
    (prev.patches or [])
    ++ [
      (fetchpatch {
        url = "https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.9-${coreutils.version}.patch";
        hash = "sha256-LRfb4heZlAUKiXl/hC/HgoqeGMxCt8ruBYZUrbzSH+Y=";
      })
    ];
})
