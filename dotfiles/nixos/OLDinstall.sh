#!/usr/bin/env zsh

# -----------------------------------------------
# Install NixOS directory through a symbolic link
# -----------------------------------------------

set -e  # Exit on any error

# Use the directory where this script is located as the source
SOURCE_DIR=$(dirname "$(realpath "$0")")
TARGET_DIR="/etc/nixos"

# Generate timestamp for backup
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_DIR="${TARGET_DIR}.old.${TIMESTAMP}"

# Function to check if directories differ
dirs_differ() {
    diff -qr "$1" "$2" >/dev/null 2>&1
    [[ $? -ne 0 ]]
}

# Backup existing target directory if it exists
if [[ -e "$TARGET_DIR" ]]; then
    echo "Backing up existing $TARGET_DIR to $BACKUP_DIR..."
    sudo mv "$TARGET_DIR" "$BACKUP_DIR"

    # Delete backup if it is identical to source
    if ! dirs_differ "$BACKUP_DIR" "$SOURCE_DIR"; then
        echo "Backup is identical to source. Removing backup..."
        sudo rm -rf "$BACKUP_DIR"
    fi
fi

# Create the symbolic link
echo "Creating symlink from $SOURCE_DIR to $TARGET_DIR..."
sudo ln -s "$SOURCE_DIR" "$TARGET_DIR"

echo "Done."
