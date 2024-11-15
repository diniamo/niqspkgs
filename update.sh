#!/usr/bin/env nix-shell
#!nix-shell -p dash nix-prefetch jaq alejandra curl git -i dash

set -ex

root="$(dirname "$0")"

for pkg in "$@"; do
    if [ -f "$pkg" ]; then
        file="$pkg"

        name="${pkg##*/}"
        name="${name%.*}"
    else
        file="$(find "$root" -name "$pkg.nix")"
        if [ -n "$file" ]; then
            name="$pkg"
        else
            printf "Couldn't find package %s." "$pkg" 1>&2
            continue
        fi
    fi

    alejandra --quiet "$file"
    content="$(cat "$file")"

    version="$(printf '%s' "$content" | grep -oP 'version = "\K[^"]+')"
    fetcher="$(printf '%s' "$content" | grep -oP 'src = \K\w+')"
    owner="$(printf '%s' "$content" | grep -oP 'owner = "\K[^"]+')"
    repo="$(printf '%s' "$content" | grep -oP 'repo = "\K[^"]+')"
    rev="$(printf '%s' "$content" | grep -oP 'rev = "\K[^"]+')"

    json="$(nix-prefetch "$fetcher" --owner "$owner" --repo "$repo" --quiet --output json)"

    commit_hash="$(printf '%s' "$json" | jaq -r '.rev')"
    if [ "$rev" = "$commit_hash" ]; then
        printf '%s is already up to date.' "$pkg" 1>&2
        continue
    fi
    date="$(date --date="$(curl -L "https://api.github.com/repos/$owner/$repo/commits/$commit_hash" | jaq -r '.commit.committer.date')" +%Y-%m-%d)"

    sed -i \
        -e "s/version = \".*\"/version = \"$date\"/" \
        -e "s/rev = \".*\"/rev = \"$commit_hash\"/" \
        -e "s/hash = \".*\"/hash = \"$(printf '%s' "$json" | jaq -r '.sha256' | sed 's,/,\\/,')\"/" \
        "$file"

    git reset # Unstage everything
    git add "$file"
    git commit --all --message="$name: $version -> $date"
done
