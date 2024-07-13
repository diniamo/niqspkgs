{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "bufresize.nvim";
  version = "2022-03-21";

  src = fetchFromGitHub {
    owner = "kwkarlwang";
    repo = "bufresize.nvim";
    rev = "3b19527ab936d6910484dcc20fb59bdb12322d8b";
    hash = "sha256-6jqlKe8Ekm+3dvlgFCpJnI0BZzWC3KDYoOb88/itH+g=";
  };
}

