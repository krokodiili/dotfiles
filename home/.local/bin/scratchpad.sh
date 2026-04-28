#!/usr/bin/env bash
# Toggle a floating WezTerm scratchpad running nvim ~/scratch.md.
# If a scratchpad window already exists, focus it. Otherwise spawn one,
# wait for it to appear, and tell AeroSpace to float it.

set -u

SCRATCH_FILE="$HOME/scratch.md"
TITLE="Scratchpad"
AERO=/opt/homebrew/bin/aerospace
WEZTERM=/opt/homebrew/bin/wezterm

find_scratchpad_id() {
    "$AERO" list-windows --all --format '%{window-id}|%{window-title}' 2>/dev/null \
        | awk -F'|' -v t="$TITLE" '$2 ~ t {print $1; exit}'
}

existing=$(find_scratchpad_id)
if [ -n "$existing" ]; then
    "$AERO" focus --window-id "$existing"
    exit 0
fi

[ -f "$SCRATCH_FILE" ] || : > "$SCRATCH_FILE"

# Snapshot all current window IDs so we can detect the new one (the spawned
# scratchpad process registers with NULL bundle-id, so we can't filter by app).
before=$("$AERO" list-windows --all --format '%{window-id}' 2>/dev/null | sort)

"$WEZTERM" start --always-new-process --cwd "$HOME" -- \
    /bin/bash -c "printf '\033]0;${TITLE}\007'; exec nvim -c 'set notitle' '$SCRATCH_FILE'" &
disown

# Poll for the new window (up to ~4s).
new_id=""
for _ in $(seq 1 20); do
    sleep 0.2
    after=$("$AERO" list-windows --all --format '%{window-id}' 2>/dev/null | sort)
    new_id=$(comm -13 <(printf '%s\n' "$before") <(printf '%s\n' "$after") | head -1)
    if [ -n "$new_id" ]; then break; fi
done

if [ -n "$new_id" ]; then
    "$AERO" layout floating --window-id "$new_id"
    "$AERO" focus --window-id "$new_id"
fi
