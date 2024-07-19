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
    rev = "0912cb71c947f48c3b361cf28e3079e169fc0416";
    hash = "sha256-MSmsbv2K8R2pUuEgSZYRWmDR808lIF285yRlDlV+3dw=";
  };
}
