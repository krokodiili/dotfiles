#!/usr/bin/env bash
# Smart-split for workspaces 1-5: when the focused workspace has 3+ windows,
# join the newest (currently focused) with its left neighbor. AeroSpace creates
# a sub-container with the OPPOSITE orientation of the parent, so on a
# horizontal root we get a vertical pair → effectively the 3rd window stacks
# under the previously-focused one.

set -u
AERO=/opt/homebrew/bin/aerospace

WS=$("$AERO" list-workspaces --focused 2>/dev/null)
[ -n "$WS" ] || exit 0

case "$WS" in
        1|2|3|4|5) ;;
        *) exit 0 ;;
esac

COUNT=$("$AERO" list-windows --workspace "$WS" 2>/dev/null | wc -l | tr -d ' ')
[ "$COUNT" -ge 3 ] || exit 0

"$AERO" join-with left 2>/dev/null || true
