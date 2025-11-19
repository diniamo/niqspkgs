{ appimageTools, fetchurl, lib }: let
  pname = "helium";
  version = "0.6.4.1";
  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    hash = "sha256-DlEFuFwx2Qjr9eb6uiSYzM/F3r2hdtkMW5drJyJt/YE=";
  };

  contents = appimageTools.extract { inherit pname version src; };
in appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/{lib/helium,applications}

    cp -r ${contents}/usr/share/* $out/share
    cp -r ${contents}/opt/helium/locales $out/share/lib/helium
    substitute ${contents}/helium.desktop $out/share/applications/helium.desktop \
      --replace-fail 'Exec=AppRun' "Exec=$out/bin/helium"
  '';

  meta = {
    description = "Private, fast, and honest web browser based on Chromium";
    homepage = "https://github.com/imputnet/helium-chromium";
    changelog = "https://github.com/imputnet/helium-linux/releases/tag/${version}";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.gpl3;
    mainProgram = "helium";
  };
}
