#!/usr/bin/env bash

RESOLUTION=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
# You can obtain an Unsplash access key from https://unsplash.com/developers
ACCESS_KEY="$UNSPLASH_ACCESS_KEY"
URL="https://api.unsplash.com/photos/random?collections=1053828&orientation=landscape"
DIR="$HOME/unsplash"

mkdir -p "$DIR"

# Fetch a random photo from Unsplash
RESPONSE=$(curl -H "Authorization: Client-ID ${ACCESS_KEY}" "$URL")
DOWNLOAD_LINK=$(echo "$RESPONSE" | jq -r ".links.download")
wget "$DOWNLOAD_LINK" -O "$DIR"/image.jpg

# Convert to png
convert "$DIR"/image.jpg "$DIR"/image.png
rm "$DIR"/image.jpg

# Resize and crop to fit screen
convert "$DIR"/image.png -resize "$RESOLUTION"^ -gravity center -extent "$RESOLUTION" "$DIR"/image.png

# Darken and blur
convert "$DIR"/image.png -fill black -colorize 20% -blur 0x8 "$DIR"/image.png
