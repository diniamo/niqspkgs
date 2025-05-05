{
  rustPlatform,
  fetchFromGitHub,
  makeBinaryWrapper,
  git,
}:
rustPlatform.buildRustPackage {
  pname = "git-clean";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "mcasper";
    repo = "git-clean";
    rev = "refs/tags/0.8.0";
    hash = "sha256-mhsmwvP2l3UVauLOqPHgGUo6rhuBNZsPah9oeX6oTxE=";
  };

  nativeBuildInputs = [makeBinaryWrapper];
  cargoHash = "sha256-/SrAPsXufshZsF+HBGzBbgQOwWv8o7UHtZ5I3PdEWms=";

  postPatch = ''
    find . -type f -name '*.rs' -exec substituteInPlace {} --replace-quiet '"git"' '"${git}/bin/git"' \;
  '';
  doCheck = false;
}
