#!/usr/bin/env bash

set -eu
cd "$(dirname "${BASH_SOURCE[0]}")"

nix build nixpkgs#node2nix

rm -f node-env.nix

result/bin/node2nix \
  -i node-packages.json \
  -o node-packages.nix \
  -c composition.nix

rm result
