{
  stdenvNoCC,
  fetchFromGitHub,
  python3,
  python3Packages,
  lib,
  hyprcursor,
  variant ? "modern",
}:
assert builtins.elem variant ["modern" "modern-right" "original" "original-right"];
  stdenvNoCC.mkDerivation (final: {
    pname = "bibata-hyprcursor";
    version = "v2.0.7";

    src = fetchFromGitHub {
      owner = "ful1e5";
      repo = "Bibata_Cursor";
      rev = final.version;
      hash = "sha256-kIKidw1vditpuxO1gVuZeUPdWBzkiksO/q2R/+DUdEc=";
    };

    nativeBuildInputs = [
      python3
      python3Packages.tomli
      python3Packages.tomli-w
      hyprcursor.out
    ];

    phases = ["unpackPhase" "configurePhase" "buildPhase" "installPhase"];

    unpackPhase = ''
      runHook preUnpack

      cp $src/configs/${
        if lib.hasSuffix "right" variant
        then "right"
        else "normal"
      }/x.build.toml config.toml

      mkdir cursors
      for cursor in $src/svg/${variant}/*; do
        cp -r $src/svg/${variant}/$(readlink $cursor) cursors
      done

      chmod -R u+w .

      runHook postUnpack
    '';

    configurePhase = ''
      runHook preConfigure

      cat << EOF > manifest.hl
      name = Bibata-${variant}
      description = The Bibata Cursor theme packaged for hyprcursor.
      version = ${final.version}
      cursors_directory = cursors
      EOF

      python ${./configure.py} config.toml cursors

      runHook postConfigure
    '';

    buildPhase = ''
      runHook preBuild
      hyprcursor-util --create . --output .
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons
      cp -r theme_Bibata-${variant} $out/share/icons/Bibata-${variant}

      runHook postInstall
    '';
  })
