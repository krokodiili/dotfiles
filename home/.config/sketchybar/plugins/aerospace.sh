#!/usr/bin/env bash
# Active = yellow haze + yellow label. Inactive = glassy white + white label.
WS="$1"
COLOR_ACCENT=0xfffaff00
COLOR_FG=0xffdddddd

if [ "$WS" = "$FOCUSED_WORKSPACE" ]; then
        sketchybar --set "space.$WS" \
                label.color=$COLOR_ACCENT \
                background.drawing=on \
                background.color=0x33faff00 \
                background.border_width=0
else
        sketchybar --set "space.$WS" \
                label.color=$COLOR_FG \
                background.drawing=on \
                background.color=0x18ffffff \
                background.border_width=0
fi
