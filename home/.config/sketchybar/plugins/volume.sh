#!/usr/bin/env bash
VOL=$(/usr/bin/osascript -e 'output volume of (get volume settings)' 2>/dev/null)
MUTED=$(/usr/bin/osascript -e 'output muted of (get volume settings)' 2>/dev/null)

[ -n "${INFO:-}" ] && [ "$INFO" != "null" ] && VOL=$INFO

ICON_HI=$(printf '\xef\x80\xa8')   # F028
ICON_LO=$(printf '\xef\x80\xa7')   # F027
ICON_OFF=$(printf '\xef\x80\xa6')  # F026

if [ "$MUTED" = "true" ]; then
        icon=$ICON_OFF
elif [ "${VOL:-0}" -ge 50 ]; then
        icon=$ICON_HI
elif [ "${VOL:-0}" -ge 10 ]; then
        icon=$ICON_LO
else
        icon=$ICON_OFF
fi

sketchybar --set "$NAME" \
        icon="$icon" \
        label="${VOL:-?}%"
