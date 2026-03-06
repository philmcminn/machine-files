#!/usr/bin/env sh

# Create a symbolic link
script_dir="$(cd "$(dirname "$0")" && pwd)"
ln -si "$script_dir/zshrc" "$HOME/.zshrc"

# Suppress additonal login-type terminal messages
touch "$HOME/.hushlogin"
