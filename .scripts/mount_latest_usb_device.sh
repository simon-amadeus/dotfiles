#!/bin/bash

# Function to get the label of the USB drive
get_usb_label() {
    local dev=$1
    blkid -o value -s LABEL "$dev"
}

# Function to get the latest inserted USB drive
get_latest_usb() {
    sudo dmesg | grep -E 'sd[a-z]: sd[a-z][0-9]' | tail -1 | awk '{print $4}' | sed 's/://'
}

# Get the latest inserted USB drive
LATEST_USB=$(get_latest_usb)

# Check if a USB drive is found
if [ -z "$LATEST_USB" ]; then
    echo "No USB drive detected."
    exit 1
fi

# Get the device path
DEV_PATH="/dev/$LATEST_USB"

# Mount the device and get the mount directory
MOUNT_DIR=$(udisksctl mount -b "$DEV_PATH" 2>&1 | grep -oP 'Mounted \K.*')

if [ -z "$MOUNT_DIR" ]; then
    echo "Failed to mount $DEV_PATH"
    exit 1
fi

# Optionally, get the label of the USB
USB_LABEL=$(get_usb_label "$DEV_PATH")

echo "Mounted $DEV_PATH at $MOUNT_DIR with label $USB_LABEL"

