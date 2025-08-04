{ nix }: nix.overrideAttrs (prev: {
  patches = (prev.patches or []) ++ [
    ./deep-overrides.patch
    ./default-flake.patch
    ./shell-variable.patch
    ./print-build-logs-setting.patch
  ];
})
