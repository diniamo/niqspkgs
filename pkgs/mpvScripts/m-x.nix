{
  fetchFromGitHub,
  buildLua,
}:
buildLua {
  pname = "M-x";
  version = "0-unstable-beee45c";

  src = fetchFromGitHub {
    owner = "Seme4eg";
    repo = "mpv-scripts";
    rev = "beee45c82e6cd7a77aeb2bbd51e364d5a2899614";
    hash = "sha256-VAWYP00FNrsdjpGdh5J8AnnZIVv9DqwEP4J4QuNFjmg=";
  };

  scriptPath = "M-x.lua";
  postInstall = ''
    mkdir $out/share/mpv/script-modules
    cp script-modules/extended-menu.lua $out/share/mpv/script-modules
  '';

  postFixup = ''
    sed -i "/^package\.path/{
      N;N
      s|.*|local em = dofile('$out/share/mpv/script-modules/extended-menu.lua')|
    }" $out/share/mpv/scripts/M-x.lua
  '';
}
