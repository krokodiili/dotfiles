#!/usr/bin/env bash
# Open the dedicated `claude` tmux session.
# - Interactive (TTY present): attach in the current shell. Inside another tmux
#   session, switch the client; outside, new-session -A so we attach.
# - Non-interactive (e.g. AeroSpace autostart): spawn a new WezTerm window on
#   workspace 8 and attach to the session there.

set -u
AERO=/opt/homebrew/bin/aerospace
WEZTERM=/opt/homebrew/bin/wezterm
TMUX_BIN=/opt/homebrew/bin/tmux
PICKER=$HOME/.local/bin/claude-project-picker.sh

if [ -t 0 ] && [ -t 1 ]; then
        # Inside an existing tmux client: ensure the session exists, then switch.
        if [ -n "${TMUX:-}" ]; then
                if ! "$TMUX_BIN" has-session -t claude 2>/dev/null; then
                        "$TMUX_BIN" new-session -d -s claude "$PICKER"
                fi
                exec "$TMUX_BIN" switch-client -t claude
        fi
        # Plain shell: take over with the session.
        exec "$TMUX_BIN" new-session -A -s claude "$PICKER"
fi

# Non-interactive — focus an existing wezterm if we already have one on ws 8,
# otherwise spawn a fresh one attached to the session.
if "$TMUX_BIN" list-clients -t claude 2>/dev/null | grep -q .; then
        wid=$("$AERO" list-windows --workspace 8 \
                --format '%{window-id}' 2>/dev/null | head -1)
        if [ -n "$wid" ]; then
                "$AERO" focus --window-id "$wid"
                exit 0
        fi
fi

"$AERO" workspace 8 2>/dev/null || true
sleep 0.3
"$WEZTERM" start --cwd "$HOME" -- \
        "$TMUX_BIN" new-session -A -s claude "$PICKER" &
disown
