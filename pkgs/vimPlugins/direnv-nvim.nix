{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "direnv.nvim";
  version = "2024-07-04";
  src = fetchFromGitHub {
    owner = "NotAShelf";
    repo = "direnv.nvim";
    rev = "f50828ef06274359ca0138e5b8952a3fa87209f4";
    hash = "sha256-jXjKOPidmS+Y0DaBZxrUat8SyRX1uQntLCmN/EdH0iY=";
  };
}
