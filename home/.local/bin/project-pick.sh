#!/usr/bin/env bash
# Pick a project from ~/work + ~/personal via fzf, sorted by recency.
# Maintains ~/.local/state/claude-projects.recent (most-recent first).
# Usage: project-pick.sh "<picker prompt>"
# Prints the chosen path on stdout; exits 1 if no selection.

set -e

RECENT_FILE="$HOME/.local/state/claude-projects.recent"
mkdir -p "$(dirname "$RECENT_FILE")"
touch "$RECENT_FILE"

ROOTS=()
for d in "$HOME/work" "$HOME/personal"; do
        [ -d "$d" ] && ROOTS+=("$d")
done
if [ ${#ROOTS[@]} -eq 0 ]; then
        echo "project-pick: no project roots found (looked in ~/work and ~/personal)" >&2
        exit 2
fi

ALL=$(/usr/bin/find "${ROOTS[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort)

# Recents (still existing) first, then everything else alphabetically; dedupe.
ORDERED=$(
        while IFS= read -r p; do
                [ -d "$p" ] && echo "$p"
        done < "$RECENT_FILE"
        echo "$ALL"
)
ORDERED=$(echo "$ORDERED" | awk 'NF && !seen[$0]++')

PROJECT=$(echo "$ORDERED" | /opt/homebrew/bin/fzf \
        --no-sort \
        --prompt="${1:-project}> " \
        --height=100% \
        --reverse)

if [ -z "$PROJECT" ]; then
        exit 1
fi

# Promote chosen project to the top of the recents file.
{
        echo "$PROJECT"
        grep -vFx "$PROJECT" "$RECENT_FILE" 2>/dev/null || true
} | head -50 > "$RECENT_FILE.tmp" && mv "$RECENT_FILE.tmp" "$RECENT_FILE"

echo "$PROJECT"
