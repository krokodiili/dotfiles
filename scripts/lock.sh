#!/usr/bin/env bash

UNSPLASH_DIR="$HOME/unsplash"

DATE=$(date +"%A, %B %-d")
# WEATHER=$(curl -s wttr.in?format="+%c+%t")

ringcolor=FFFFFFFF
insidecolor=00000000
linecolor=00000000
separatorcolor=00000000

ringvercolor=00000000
insidevercolor=00000000

ringwrongcolor=00000000
insidewrongcolor=00000000

keyhlcolor=AAAAAAFF
bshlcolor=AAAAAAFF

if [[ "$#" -eq 0 ]]; then
    SUSPEND=0
elif [[ "$#" -eq 1 && "$1" = '-s' ]]; then
    SUSPEND=1
else
    echo "Usage: $(basename $0) [-s]" >&2
    exit 1
fi

if [[ "$SUSPEND" -eq 0 ]]; then
    ARGS="-n"
else
    ARGS=""
fi

betterlockscreen --lock -u ~/wallpapers --display 2 --dim 20


# For desktop
# if [[ "$SUSPEND" -eq 1 ]]; then
#     if type nvidia-smi 2>/dev/null; then
#         if [[ $(nvidia-smi --query-compute-apps=pid --format=csv,noheader | wc -l) -eq 0 ]]; then
#             systemctl suspend
#         fi
#     else
#         systemctl suspend
#     fi
# fi

# feh --bg-scale $HOME/unsplash/image.png

# if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
#     unsplash.sh > $HOME/unsplash/log 2>&1 &
# fi
