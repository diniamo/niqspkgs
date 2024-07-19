{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "fastaction.nvim";
  version = "2024-07-19";

  src = fetchFromGitHub {
    owner = "Chaitanyabsprip";
    repo = "fastaction.nvim";
    rev = "2384dea7ba81d2709d0bee0e4bc7a8831ff13a9d";
    hash = "sha256-L7na78FsE+QHlEwxMpiwQcoOPhtmrknvdTZfzUoDANI=";
  };
}
