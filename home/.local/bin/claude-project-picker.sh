#!/usr/bin/env bash
# Pick a project (most-recent first) and start `claude` there. Used as the
# command for `tmux new-window` in the dedicated `claude` session — claude
# becomes the new window's process; the window is renamed to the project.

set -e

PROJECT=$(/Users/melty/.local/bin/project-pick.sh "claude project") || exit 0

NAME=$(basename "$PROJECT")
if [ -n "${TMUX:-}" ]; then
        /opt/homebrew/bin/tmux rename-window "$NAME"
fi

cd "$PROJECT"
exec /Users/melty/.local/bin/claude
