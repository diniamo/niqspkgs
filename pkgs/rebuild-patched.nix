{inputs, system, self}: inputs.rebuild.packages.${system}.default.override {
  nix-output-monitor = self.packages.${system}.nom-patched;
}
