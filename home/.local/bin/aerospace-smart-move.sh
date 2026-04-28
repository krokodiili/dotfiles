#!/usr/bin/env bash
# Smart move: try moving the focused window within its workspace. If it's
# already at the boundary in that direction (no neighbor), move it to the
# adjacent monitor instead.
#
# Usage: aerospace-smart-move.sh (left|right|up|down)

set -u
DIR="${1:?direction required}"
AERO=/opt/homebrew/bin/aerospace

if ! "$AERO" move --boundaries-action fail "$DIR" 2>/dev/null; then
        if "$AERO" move-node-to-monitor "$DIR" 2>/dev/null; then
                "$AERO" focus-monitor "$DIR" 2>/dev/null || true
        fi
fi
