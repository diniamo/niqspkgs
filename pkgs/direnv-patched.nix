{
  direnv,
  fetchFromGitHub,
}:
direnv.overrideAttrs {
  pname = "direnv-patched";

  src = fetchFromGitHub {
    owner = "diniamo";
    repo = "direnv";
    rev = "706b854d07578f240f861997c5944055b7108c57";
    hash = "sha256-sTpp05sDiM5SeBsXuKt80epUhm+O3HEweZS8YkJxJXA=";
  };
}
