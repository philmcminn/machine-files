#!/bin/zsh

# Check for root/sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo"
    exit 1
fi

# Get new name from argument or prompt
if [[ -n "$1" ]]; then
    NEW_NAME="$1"
else
    print -n "Enter new computer name: "
    read NEW_NAME
fi

if [[ -z "$NEW_NAME" ]]; then
    echo "No name provided. Exiting."
    exit 1
fi

# Sanitize hostname (lowercase, hyphens only, no spaces or special chars)
HOSTNAME_SAFE="${NEW_NAME:l}"           # lowercase
HOSTNAME_SAFE="${HOSTNAME_SAFE// /-}"  # spaces to hyphens
HOSTNAME_SAFE="${(S)HOSTNAME_SAFE/[^a-z0-9-]/}"  # strip invalid chars

echo "Setting ComputerName:   $NEW_NAME"
echo "Setting HostName:       $HOSTNAME_SAFE"
echo "Setting LocalHostName:  $HOSTNAME_SAFE"
echo ""

# 1. ComputerName — friendly name shown in Finder, Sharing prefs, AirDrop
scutil --set ComputerName "$NEW_NAME"

# 2. HostName — traditional BSD hostname, used by Terminal prompt etc.
scutil --set HostName "$HOSTNAME_SAFE"

# 3. LocalHostName — Bonjour/mDNS name (the "MacBook.local" name)
scutil --set LocalHostName "$HOSTNAME_SAFE"

# 4. /etc/hostname — some tools read this directly
echo "$HOSTNAME_SAFE" > /etc/hostname

# 5. /etc/hosts — update any existing self-referencing entries
if grep -q "127.0.0.1" /etc/hosts; then
    # Add entry if not already present for this name
    if ! grep -q "$HOSTNAME_SAFE" /etc/hosts; then
        echo "127.0.0.1    $HOSTNAME_SAFE" >> /etc/hosts
    fi
fi

# 6. Flush DNS cache to pick up changes
dscacheutil -flushcache
killall -HUP mDNSResponder 2>/dev/null

echo "Done. You may need to restart your terminal or log out for all changes to take effect."
