#!/usr/bin/env nix-shell
#!nix-shell -p dash nix-prefetch jaq alejandra -i dash

set -e

for pkg in "$@"; do
    if [ ! -f "$pkg" ]; then
        for file in $(find "$(dirname "$0")" -name '*.nix'); do
            if [ "$(basename "$file")" = "$pkg.nix" ]; then
                pkg="$file"
                break
            fi
        done
    fi

    if [ ! -f "$pkg" ]; then
        echo "Couldn't find package $pkg!" 1>&2
        continue
    fi

    alejandra --quiet "$pkg"

    fetcher="$(grep -oP 'src = \K\w+' "$pkg")"
    owner="$(grep -oP 'owner = "\K[^"]+' "$pkg")"
    repo="$(grep -oP 'repo = "\K[^"]+' "$pkg")"

    json="$(nix-prefetch "$fetcher" --owner "$owner" --repo "$repo" --quiet --output json)"

    sed -i \
        -e "s/rev = \".*\"/rev = \"$(printf '%s' "$json" | jaq -r '.rev')\"/" \
        -e "s/hash = \".*\"/hash = \"$(printf '%s' "$json" | jaq -r '.sha256' | sed 's,/,\\/,')\"/" \
        "$pkg"
done
