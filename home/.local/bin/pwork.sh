#!/usr/bin/env bash
# Focused-work layout: pick a project, ensure a `focus-<project>` tmux session
# exists with nvim left + claude right, and attach in the current shell.
# Inside another tmux client → switch-client; outside → attach.

set -e

PROJECT=$(/Users/melty/.local/bin/project-pick.sh "focused project") || exit 0
NAME=$(basename "$PROJECT")
SESSION="focus-$NAME"

TMUX_BIN=/opt/homebrew/bin/tmux
CLAUDE=/Users/melty/.local/bin/claude

if ! "$TMUX_BIN" has-session -t "$SESSION" 2>/dev/null; then
        "$TMUX_BIN" new-session -d -s "$SESSION" -c "$PROJECT" -x 240 -y 60

        # Pane 0 (left, 60%): nvim
        "$TMUX_BIN" send-keys -t "$SESSION":0.0 "nvim ." Enter

        # Pane 1 (right top, 40% × 70%): claude
        "$TMUX_BIN" split-window -h -p 40 -t "$SESSION":0 -c "$PROJECT"
        "$TMUX_BIN" send-keys -t "$SESSION":0.1 "$CLAUDE" Enter

        # Pane 2 (right bottom, 40% × 30%): taskwarrior for this project
        "$TMUX_BIN" split-window -p 30 -t "$SESSION":0.1 -c "$PROJECT"
        "$TMUX_BIN" send-keys -t "$SESSION":0.2 "task project:$NAME list 2>/dev/null || task list" Enter

        "$TMUX_BIN" select-pane -t "$SESSION":0.0
fi

if [ -n "${TMUX:-}" ]; then
        exec "$TMUX_BIN" switch-client -t "$SESSION"
else
        exec "$TMUX_BIN" attach -t "$SESSION"
fi
