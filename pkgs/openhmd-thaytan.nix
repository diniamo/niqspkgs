{
  openhmd,
  fetchFromGitHub,
  libusb1,
  opencv
}: (openhmd.override { withExamples = false; }).overrideAttrs (prev: {
  version = "0-unstable-04f5276";

  src = fetchFromGitHub {
    owner = "thaytan";
    repo = "OpenHMD";
    rev = "04f5276bfc679968ceea62e4d1df6cbe6376941c";
    hash = "sha256-Av8Jgta47dgsAsMdKV3It+MCzcaHmbMkCc4KZIbjeK0=";
  };

  buildInputs = prev.buildInputs ++ [
    libusb1
    opencv
  ];
})
