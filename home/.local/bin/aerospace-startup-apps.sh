#!/usr/bin/env bash
# Launch the daily app set and route each to its workspace.
# Invoked from aerospace `after-startup-command` (i.e. on AeroSpace start at login).

set -u
AERO=/opt/homebrew/bin/aerospace

launch_on() {
    local ws="$1"; shift
    "$AERO" workspace "$ws" 2>/dev/null || true
    sleep 0.3
    "$@"
}

# 1: Brave (Kuura profile)
launch_on 1 open -a "Brave Browser" --args --profile-directory="Profile 1"
sleep 1.8

# 2: WezTerm
launch_on 2 open -a WezTerm
sleep 1.5

# 4: Brave (Henkilökohtainen profile)
launch_on 4 open -a "Brave Browser" --args --profile-directory="Default"
sleep 1.8

# 5: Slack
launch_on 5 open -a Slack
sleep 1.5

# 6: Spotify
launch_on 6 open -a Spotify
sleep 1.5

# 8: dedicated `claude` tmux session in a WezTerm window
"$HOME/.local/bin/claude-space.sh"
sleep 1.5

# Land on workspace 6 (secondary monitor, default focus)
"$AERO" workspace 6
