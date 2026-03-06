#!/usr/bin/env sh

set -eu
readonly script_dir="$(cd "$(dirname "$0")" && pwd)"
readonly target="$HOME/.config/ghostty/config"

if [ "${P_MAC:-}" = "true" ]; then
    source="$script_dir/config-mac"
elif [ "${P_LINUX:-}" = "true" ]; then
    source="$script_dir/config-linux"
else
    printf 'Error: cannot determine Mac or Linux (neither $P_MAC nor $P_LINUX is true).\n' >&2
    exit 1
fi

if [ -e "$target" ] || [ -L "$target" ]; then
    printf '%s already exists. Overwrite? [y/N] ' "$target"
    read -r response
    if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
        printf 'Aborting.\n'
        exit 0
    fi
    rm "$target"
fi

mkdir -p "$(dirname "$target")"
ln -s "$source" "$target"
printf 'Symlinked %s -> %s\n' "$target" "$source"
