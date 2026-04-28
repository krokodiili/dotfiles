#!/usr/bin/env bash
# Memory used % (active + wired + compressed) of total. Yellow above 80%.
PAGE_SIZE=$(vm_stat | head -1 | awk -F'[ .]+' '{print $8}')
TOTAL=$(/usr/sbin/sysctl -n hw.memsize)

read_pages() {
        vm_stat | awk -F'[: .]+' -v key="$1" '$0 ~ key {print $(NF-1); exit}'
}

ACTIVE=$(read_pages 'Pages active')
WIRED=$(read_pages 'Pages wired down')
COMPRESSED=$(read_pages 'Pages occupied by compressor')
USED_BYTES=$(( (ACTIVE + WIRED + COMPRESSED) * PAGE_SIZE ))
PERC=$(( USED_BYTES * 100 / TOTAL ))

COLOR_FG=0xffdddddd
COLOR_ACCENT=0xfffaff00
color=$COLOR_FG
[ "$PERC" -ge 80 ] && color=$COLOR_ACCENT

sketchybar --set "$NAME" \
        label="${PERC}%" \
        label.color=$color \
        icon.color=$color
