{
  satty,
  fetchFromGitHub,
}:
satty.overrideAttrs {
  version = "2024-07-26";

  src = fetchFromGitHub {
    owner = "gabm";
    repo = "Satty";
    rev = "04fae6c9072bed46913a85762db17d58718d85b3";
    hash = "sha256-0vZvHCS/vzYIhrTwauaPBfoz9p2E7jVjfBIlc6IYFpQ=";
  };
}
