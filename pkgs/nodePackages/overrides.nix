{pkgs}: final: prev: {
  cbmp = prev.cbmp.override {
    nativeBuildInputs = [pkgs.makeWrapper];
    prePatch = "export PUPPETEER_SKIP_DOWNLOAD=1";
    postInstall = "wrapProgram $out/bin/cbmp --set PUPPETEER_EXECUTABLE_PATH ${pkgs.chromium.outPath}/bin/chromium";
  };
}
