{inputs', self'}: inputs'.nq.packages.default.override {
  nix-output-monitor = self'.packages.nom-patched;
}
