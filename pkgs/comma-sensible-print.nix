{
  comma,
  fetchFromGitHub,
}:
comma.overrideAttrs (prev: {
  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "comma";
    rev = "062daa39f1ab8a923f5df03745dd2546a5fae41c";
    hash = "sha256-D5a+JV4AOPTyG+5E2m2XNcWJH0dRwJGgd4wDd0R/mi8=";
  };

  patches = (prev.patches or []) ++ [./patches/comma-sensible-print.patch];
})
