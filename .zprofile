# Init sway session
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec sway
    logout
fi

