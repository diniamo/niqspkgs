{
  stdenv,
  fetchFromGitHub,
  lib,
}:
stdenv.mkDerivation {
  pname = "bencode-pretty";
  version = "2017.12.26";

  src = fetchFromGitHub {
    owner = "tool-maker";
    repo = "bencode-pretty";
    rev = "7af59185ba12dd8b26a68824523b12f3f9ee2fb4";
    hash = "sha256-PZMMfkwJC6fmI/2ZDV0nT6HVNHjw6CrraMHqPe0l7EY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -Dm755 bencode_pretty bencode_prettier bencode_prettiest bencode_unpretty $out/bin

    runHook postInstall
  '';

  meta = {
    description = "Programs to create a \"pretty\" version of a bencoded file that can be easily examined and edited, and another to \"unpretty\" it again.";
    homepage = "https://github.com/tool-maker/bencode-pretty";
    maintainers = [lib.maintainers.diniamo];
  };
}
