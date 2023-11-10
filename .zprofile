# Init sway session
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    #export GTK_THEME="Adwaita:dark"
    #export GTK_ICON_THEME="Adwaita"
    #export GTK_FONT_NAME="DejaVu Sans 11"

    exec sway
    logout
fi

