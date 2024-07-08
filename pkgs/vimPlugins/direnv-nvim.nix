{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "direnv.nvim";
  version = "2024-07-08_1";

  src = fetchFromGitHub {
    owner = "NotAShelf";
    repo = "direnv.nvim";
    rev = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
    hash = "sha256-nWdAIchqGsWiF0cQ7NwePRa1fpugE8duZKqdBaisrAc=";
  };
}
