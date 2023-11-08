#!/bin/sh

swaymsg "output * power on"

sleep 1

swaymsg "output eDP-1 disable"
swaymsg "output HDMI-1 disable"

sleep 1

swaymsg "output eDP-1 enable"
swaymsg "output HDMI-1 enable"

