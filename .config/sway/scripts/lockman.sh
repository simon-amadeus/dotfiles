#!/bin/sh
# Turn off display while lock screen is showing, then restore on unlock.
swayidle \
    timeout 300 'swaymsg "output * power off"' \
    resume  'swaymsg "output * power on"' &
IDLE_PID=$!
swaylock -f -C ~/.config/swaylock/config
kill "$IDLE_PID"
