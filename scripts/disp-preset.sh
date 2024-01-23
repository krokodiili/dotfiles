#!/bin/zsh

SCRIPT_DIR=~/scripts/display/
SELECTED_SCRIPT=$(ls $SCRIPT_DIR | rofi -dmenu -p "Select a script")

if [ -n "$SELECTED_SCRIPT" ]; then
    zsh "$SCRIPT_DIR/$SELECTED_SCRIPT"
else
    echo "No script selected."
fi
