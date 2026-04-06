#!/bin/sh
# Stow all dotfile packages into $HOME

cd "$(dirname "$0")" || exit 1

for d in */; do
    pkg="${d%/}"
    echo "stowing $pkg"
    stow "$pkg"
done
