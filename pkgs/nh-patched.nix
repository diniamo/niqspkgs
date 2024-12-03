{
  nh,
  self,
  stdenv,
  fetchFromGitHub,
}:
(nh.override {
  nix-output-monitor = self.packages.${stdenv.system}.nom-patched;
})
.overrideAttrs (prev: rec {
  pname = "nh-patched";
  version = "2024-11-15";

  src = fetchFromGitHub {
    owner = "viperML";
    repo = "nh";
    rev = "ed2116065353603859852efbff5702489d965684";
    hash = "sha256-k8rz5RF1qi7RXzQYWGbw5pJRNRFIdX85SIYN+IHiVL4=";
  };

  cargoDeps = prev.cargoDeps.overrideAttrs {
    inherit src;
    outputHash = "sha256-HfPzoAai6wK5IqNQY7yFVXatMcia9z0I84QNmNzHRoc=";
  };
})
