{
  fetchFromGitHub,
  buildLua,
}:
buildLua {
  pname = "SimpleUndo";
  version = "2023-09-25";

  src = fetchFromGitHub {
    owner = "Eisa0";
    repo = "mpv-scripts";
    tag = "25-09-2023";
    hash = "sha256-tChANE37jKX2IMF3TC1QIBeDqZeCJ7Cf7LxKFXeS2dg=";
  };

  scriptPath = "scripts/SimpleUndo.lua";
}
