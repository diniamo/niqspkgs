{
  fetchFromGitHub,
  buildLua,
}:
buildLua rec {
  pname = "SimpleUndo";
  version = "2023-09-25";

  src = fetchFromGitHub {
    owner = "Eisa01";
    repo = "mpv-scripts";
    rev = version;
    hash = "sha256-tChANE37jKX2IMF3TC1QIBeDqZeCJ7Cf7LxKFXeS2dg=";
  };

  scriptPath = "scripts/${pname}.lua";
}
