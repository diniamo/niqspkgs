{
  stdenvNoCC,
  makeBinaryWrapper,
  nushell,
  lib,
  coreutils,
  nix-output-monitor,
  nvd,
  openssh
}:
stdenvNoCC.mkDerivation {
  pname = "rebuild";
  version = "0.2.0";

  src = ./main.nu;
  dontUnpack = true;

  nativeBuildInputs = [makeBinaryWrapper];
  buildInputs = [nushell];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp $src $out/bin/rebuild

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/rebuild \
      --prefix PATH : ${lib.makeBinPath [coreutils nix-output-monitor nvd openssh]}
  '';

  meta = {
    description = "Profile-based rebuild script with remote deployment support";
    homepage = "https://github.com/diniamo/niqspkgs/tree/main/pkgs/rebuild";
    license = lib.licenses.eupl12;
    platforms = nushell.meta.platforms;
    maintainers = [lib.maintainers.diniamo];
    mainProgram = "rebuild";
  };
}
