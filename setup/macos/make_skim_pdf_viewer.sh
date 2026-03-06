#!/usr/bin/env sh
set -eu

# Get Skim bundle identifier
skim_bundle_id=$(osascript -e 'id of app "Skim"')
if [ -z "$skim_bundle_id" ]; then
    printf 'Skim not found. Is it installed?\n' >&2
    exit 1
fi
printf 'Using Skim bundle ID: %s\n' "$skim_bundle_id"

# Set Skim as default PDF handler
duti -s "$skim_bundle_id" pdf all
printf 'Skim is now the default PDF viewer\n'
