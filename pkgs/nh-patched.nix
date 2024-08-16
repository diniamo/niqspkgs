{
  nh,
  self,
  stdenv,
}:
nh.override {
  nix-output-monitor = self.packages.${stdenv.system}.nom-patched;
}
