#!/bin/sh

swaymsg "reload"

sleep 1

swaymsg "output * power on"

sleep 1

swaymsg "output * disable"

sleep 1

swaymsg "output * enable"

sleep 1

swaymsg "reload"

