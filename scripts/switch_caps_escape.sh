#!/bin/zsh
# Path to your hyprland.conf file
CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"

# Check if the line is commented
if grep -q "#kb_options = caps:swapescape" "$CONFIG_FILE"; then
	# Uncomment the line
	sed -i 's/#kb_options = caps:swapescape/kb_options = caps:swapescape/g' "$CONFIG_FILE"
	# Display notification
	notify-send "Caps and Escape keys are in their default state."
else
	# Comment the line
	sed -i 's/kb_options = caps:swapescape/#kb_options = caps:swapescape/g' "$CONFIG_FILE"
	# Display notification
	notify-send "Caps and Escape keys have been swapped."
fi
setxkbmap -option caps:escape
