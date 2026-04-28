#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${HOME}/wallpapers"

shopt -s nullglob nocaseglob
files=("$WALLPAPER_DIR"/*.{jpg,jpeg,png,heic,heif,tiff,tif,webp,bmp})
shopt -u nullglob nocaseglob

if [ ${#files[@]} -eq 0 ]; then
    echo "$(date -Iseconds) no wallpapers found in $WALLPAPER_DIR" >&2
    exit 0
fi

pick="${files[RANDOM % ${#files[@]}]}"

/usr/bin/osascript <<EOF
tell application "System Events"
    tell every desktop
        set picture to POSIX file "$pick"
    end tell
end tell
EOF

echo "$(date -Iseconds) set wallpaper to $pick"
