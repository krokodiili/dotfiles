#!/bin/bash

xrandr --output "$SIDE_MONITOR" --auto --panning 0x0 --output "$WORK_MONITOR" --auto --right-of "$SIDE_MONITOR"

exec ~/scripts/poly

nitrogen --restore &
