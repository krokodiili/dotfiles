#!/usr/bin/env bash
NPCLI=/opt/homebrew/bin/nowplaying-cli

TITLE=$("$NPCLI" get title 2>/dev/null)
RATE=$("$NPCLI" get playbackRate 2>/dev/null)

if [ "$TITLE" = "null" ] || [ -z "$TITLE" ]; then
        sketchybar --set "$NAME" drawing=off
        exit 0
fi

ICON_PLAY=$(printf '\xef\x81\x8b')   # F04B
ICON_PAUSE=$(printf '\xef\x81\x8c')  # F04C

case "$RATE" in
        1*) icon=$ICON_PAUSE ;;   # currently playing → click pauses
        *)  icon=$ICON_PLAY ;;    # currently paused → click plays
esac

sketchybar --set "$NAME" \
        drawing=on \
        icon="$icon"
