[ -f ~/.profile ] && source ~/.profile

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec sway
    echo "Failed to start sway" >&2
    exit 1
fi
