{
  rustPlatform,
  fetchFromGitHub,
  makeBinaryWrapper,
  git,
}:
rustPlatform.buildRustPackage{
  pname = "git-clean";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "mcasper";
    repo = "git-clean";
    rev = "refs/tags/0.8.0";
    hash = "sha256-mhsmwvP2l3UVauLOqPHgGUo6rhuBNZsPah9oeX6oTxE=";
  };

  cargoHash = "sha256-7ePRJFYjyzjR8TUL1yMMhqI3z76Rw+5cuX6NpyrdidY=";

  doCheck = false;

  nativeBuildInputs = [makeBinaryWrapper];
  postFixup = "wrapProgram $out/bin/git-clean --prefix PATH : ${git}/bin";
}
