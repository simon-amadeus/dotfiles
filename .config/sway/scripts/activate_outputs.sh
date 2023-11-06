#!/bin/sh

swaymsg "output * power on" && sleep 1 && swaymsg "output * disable" && sleep 1 && swaymsg "output * enable"
