# Wayland session environment — single source of truth is
# ~/.config/environment.d/wayland.conf (also read by systemd user units).
set -a
. "$HOME/.config/environment.d/wayland.conf"
set +a

# Default applications
command -v helix >/dev/null 2>&1 && export EDITOR=helix
command -v firefox-developer-edition >/dev/null 2>&1 && export BROWSER=firefox-developer-edition
