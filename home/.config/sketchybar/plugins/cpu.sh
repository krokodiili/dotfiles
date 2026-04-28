#!/usr/bin/env bash
CPU=$(top -l 1 -s 0 | awk -F'[%, ]+' '/CPU usage/ {printf "%d", $3 + $5}')
COLOR_FG=0xffdddddd
COLOR_ACCENT=0xfffaff00
color=$COLOR_FG
[ "${CPU:-0}" -ge 70 ] && color=$COLOR_ACCENT

sketchybar --set "$NAME" \
        label="${CPU:-0}%" \
        label.color=$color \
        icon.color=$color
