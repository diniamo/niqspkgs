{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "NeoZoom.lua";
  version = "2024-08-11";

  src = fetchFromGitHub {
    owner = "nyngwang";
    repo = "NeoZoom.lua";
    rev = "c97a0197548c1e9b559e4fa41ab3f7782c93e613";
    hash = "sha256-O5ovnf0tYbyGKC0OzE05WNRv84mVTocfh0lKk3+cSsY=";
  };
}
