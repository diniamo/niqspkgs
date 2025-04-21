{
  fetchFromGitHub,
  lib,
  llvmPackages,
  makeBinaryWrapper,
  which,
}: let
  inherit (llvmPackages) stdenv;
in
  stdenv.mkDerivation {
    pname = "odin";
    version = "dev-2025-04";

    src = fetchFromGitHub {
      owner = "odin-lang";
      repo = "Odin";
      tag = "dev-2025-04";
      hash = "sha256-dVC7MgaNdgKy3X9OE5ZcNCPnuDwqXszX9iAoUglfz2k=";
    };

    patches = [
      ./patches/odin-system-raylib.patch
    ];

    dontConfigure = true;
    LLVM_CONFIG = "${llvmPackages.llvm.dev}/bin/llvm-config";

    buildFlags = ["release"];

    nativeBuildInputs = [
      makeBinaryWrapper
      which
    ];

    postPatch = ''
      patchShebangs build_odin.sh

      rm -r vendor/raylib/{linux,macos,macos-arm64,wasm,windows}
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp odin $out/bin/odin

      mkdir -p $out/share
      cp -r {base,core,shared,vendor} $out/share

      # make -C "$out/share/vendor/cgltf/src/"
      # make -C "$out/share/vendor/stb/src/"
      # make -C "$out/share/vendor/miniaudio/src/"

      wrapProgram $out/bin/odin \
        --set-default ODIN_ROOT $out/share \
        --prefix PATH : ${
        lib.makeBinPath (
          with llvmPackages; [
            bintools
            llvm
            clang
            lld
          ]
        )
      }

      runHook postInstall
    '';
  }
