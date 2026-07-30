#!/bin/sh
# Recover stuck outputs: power everything on, then reload sway, which
# also restarts kanshi (exec_always in config.d/output).
swaymsg "output * power on"
swaymsg reload
