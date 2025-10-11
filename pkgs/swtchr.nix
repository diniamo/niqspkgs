{ rustPlatform, fetchFromGitHub, pkg-config, gtk4, gtk4-layer-shell }:
rustPlatform.buildRustPackage {
  pname = "swtchrd";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "lostatc";
    repo = "swtchr";
    tag = "v0.1.3";
    hash = "sha256-zAvkL5qdFN2oSGttjndtn3uLEYVitZvJS1bUF1UG/xg=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ gtk4 gtk4-layer-shell ];

  cargoHash = "sha256-hImlVfvTggGKsnZvjvJ3et8/Oje7Y2/F7HxexI/jUIg=";

  meta.mainProgram = "swtchr";
}
