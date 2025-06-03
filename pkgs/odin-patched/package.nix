{odin, fetchFromGitHub}: odin.overrideAttrs (prev: {
  pname = "odin-patched";
  version = "0-unstable-a2c0720";

  src = fetchFromGitHub {
    owner = "odin-lang";
    repo = "Odin";
    rev = "a2c0720fb046187bb00f5f3beeab4e9c284b18f0";
    hash = "sha256-T3CCey2ql2qI8TJVzpxp7cS1wXy2CCGRmvFSmt2GQos=";
  };

  # The outdated patch fails the build. It's for Darwin anyway.
  patches = [ # (prev.patches or []) ++ [
    ./system-raylib.patch
  ];

  postPatch = prev.postPatch + ''
    rm -r vendor/raylib/{linux,macos,macos-arm64,wasm,windows}
  '';
})
