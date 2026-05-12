#!/bin/bash

selected=$(printf '%s\n' \
    "󰍃  Logout" \
    "󰒲  Suspend" \
    "󰜉  Reboot" \
    "󰐥  Shutdown" \
    | wofi --conf="$HOME/.config/wofi/config.power" --style="$HOME/.config/wofi/style.css")

case "${selected,,}" in
    *logout*)   swaymsg exit ;;
    *suspend*)  exec systemctl suspend ;;
    *reboot*)   exec systemctl reboot ;;
    *shutdown*) exec systemctl poweroff -i ;;
esac
