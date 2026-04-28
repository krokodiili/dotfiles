#!/usr/bin/env bash
PMSET=$(/usr/bin/pmset -g batt)
PERC=$(echo "$PMSET" | /usr/bin/grep -Eo '\d+%' | head -1 | tr -d '%')
CHARGING=$(echo "$PMSET" | /usr/bin/grep -ic 'AC Power\|charging')

COLOR_FG=0xffdddddd
COLOR_ACCENT=0xfffaff00

# UTF-8 byte sequences for FA glyphs.
ICON_FULL=$(printf '\xef\x89\x80')   # F240
ICON_3Q=$(printf '\xef\x89\x81')     # F241
ICON_HALF=$(printf '\xef\x89\x82')   # F242
ICON_Q=$(printf '\xef\x89\x83')      # F243
ICON_EMPTY=$(printf '\xef\x89\x84')  # F244
ICON_BOLT=$(printf '\xef\x83\xa7')   # F0E7

color=$COLOR_FG
icon=$ICON_FULL

if [ "$CHARGING" -gt 0 ]; then
        icon=$ICON_BOLT
        color=$COLOR_ACCENT
elif [ "${PERC:-100}" -ge 90 ]; then
        icon=$ICON_FULL
elif [ "${PERC:-100}" -ge 70 ]; then
        icon=$ICON_3Q
elif [ "${PERC:-100}" -ge 40 ]; then
        icon=$ICON_HALF
elif [ "${PERC:-100}" -ge 20 ]; then
        icon=$ICON_Q
else
        icon=$ICON_EMPTY
        color=$COLOR_ACCENT
fi

sketchybar --set "$NAME" \
        icon="$icon" \
        icon.color=$color \
        label="${PERC:-?}%" \
        label.color=$color
