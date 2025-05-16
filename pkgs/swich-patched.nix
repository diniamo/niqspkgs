{inputs', self'}: inputs'.swich.packages.default.override {
  nix-output-monitor = self'.packages.nom-patched;
}
