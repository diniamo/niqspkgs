#!/usr/bin/env nix-shell
#!nix-shell -p dash nix-prefetch jaq alejandra curl git -i dash

set -e

for pkg in "$@"; do
    if [ -f "$pkg" ]; then
        file="$pkg"

        name="${pkg##*/}"
        name="${name%.*}"
    else
        file="$(find "${0%/*}" -name "$pkg.nix")"
        if [ -n "$file" ]; then
            # file="$file"
            name="$pkg"
        else
            echo "Couldn't find package $pkg!" 1>&2
            continue
        fi
    fi

    alejandra --quiet "$file"
    content="$(cat "$file")"

    version="$(printf '%s' "$content" | grep -oP 'version = "\K[^"]+')"
    fetcher="$(printf '%s' "$content" | grep -oP 'src = \K\w+')"
    owner="$(printf '%s' "$content" | grep -oP 'owner = "\K[^"]+')"
    repo="$(printf '%s' "$content" | grep -oP 'repo = "\K[^"]+')"

    json="$(nix-prefetch "$fetcher" --owner "$owner" --repo "$repo" --quiet --output json)"

    commit_hash="$(printf '%s' "$json" | jaq -r '.rev')"
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
