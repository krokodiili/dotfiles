killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

polybar -r left &
polybar -r tray &
if [[ -n "$SIDE_MONITOR" ]]; then
	# Execute your polybar script here
	polybar -r right &
fi
