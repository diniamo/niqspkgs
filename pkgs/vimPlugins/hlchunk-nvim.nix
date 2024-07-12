{
  buildVimPlugin,
  fetchFromGitHub,
}:
buildVimPlugin {
  pname = "hlchunk-nvim";
  version = "2024-07-12";

  src = fetchFromGitHub {
    owner = "shellRaining";
    repo = "hlchunk.nvim";
    rev = "0eb86c76ce37519a7bcdca8711a54fd1c4ff17f8";
    hash = "sha256-WWLChCceqCfQ9CXDgQ37U8LGrLtUzBOk8aTbKroG+5o=";
  };
}
