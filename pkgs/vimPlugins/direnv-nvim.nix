{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "direnv.nvim";
  version = "2024-07-08";

  src = fetchFromGitHub {
    owner = "NotAShelf";
    repo = "direnv.nvim";
    rev = "abdbf48f5665b8eaf54c07cc11fb8b3af96c41fd";
    hash = "sha256-c6GHD3oZBEa44pCAMuELPoVXdv6GkAeRMVxnoqN3yAY=";
  };
}
