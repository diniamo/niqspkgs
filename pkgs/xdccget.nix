{ stdenv, fetchFromGitHub, openssl }:
stdenv.mkDerivation {
  pname = "xdccget";
  version = "0-unstable-9ecc0db";

  src = fetchFromGitHub {
    owner = "Fantastic-Dave";
    repo = "xdccget";
    rev = "9ecc0db460c0d03a84fc4db71f3ce628af7f97f7";
    hash = "sha256-Aa5H+rcFFkRB4uw24L591nYyt30ssmjU62/ZdG2PiEI=";
  };

  nativeBuildInputs = [ openssl ];

  installPhase = ''
    mkdir -p $out/bin
    cp xdccget $out/bin
  '';

  meta.mainProgram = "xdccget";
}
