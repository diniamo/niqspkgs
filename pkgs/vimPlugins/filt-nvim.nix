{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "filt.nvim";
  version = "2024-06-19";

  src = fetchFromGitHub {
    owner = "ggandor";
    repo = "flit.nvim";
    rev = "1ef72de6a02458d31b10039372c8a15ab8989e0d";
    hash = "sha256-lLlad/kbrjwPE8ZdzebJMhA06AqpmEI+PJCWz12LYRM=";
  };
}
