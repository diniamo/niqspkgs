{ nix }: nix.appendPatches [
  ./default-flake.patch
  ./shell-variable.patch
  ./print-build-logs-setting.patch
]
