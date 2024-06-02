{
  buildNpmPackage,
  fetchFromGitHub,
  makeWrapper,
  chromium,
  lib,
}:
buildNpmPackage rec {
  pname = "cbmp";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "ful1e5";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-vOEz2KGJLCiiX+Or9y0JE9UF7sYbwaSCVm5iBv4jIdI=";
  };
  npmDepsHash = "sha256-zfZAZqnkKwsGkwGgfPvb3me4tFgAofE5H3d23mdAtqY=";

  nativeBuildInputs = [makeWrapper];

  env.PUPPETEER_SKIP_DOWNLOAD = true;
  postPatch = "cp ${./package-lock.json} package-lock.json";
  postInstall = "wrapProgram $out/bin/cbmp --set PUPPETEER_EXECUTABLE_PATH ${lib.getExe chromium}";

  meta = {
    description = "CLI App for converting cursor svg file to png. ";
    homepage = "https://github.com/ful1e5/cbmp";
    license = lib.licenses.mit;
    mainProgram = "cbmp";
    maintainers = [lib.maintainers.diniamo];
  };
}
