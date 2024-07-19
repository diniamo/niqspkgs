{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "fastaction.nvim";
  version = "2024-07-16";

  src = fetchFromGitHub {
    owner = "Chaitanyabsprip";
    repo = "fastaction.nvim";
    rev = "17c9bd382aea14a0575b1e6c4d21c50cb8f30543";
    hash = "sha256-MzFpD3c9WdLHhibOejZKIUFhCipX5ZWefCMO6LXOKkA=";
  };
}
