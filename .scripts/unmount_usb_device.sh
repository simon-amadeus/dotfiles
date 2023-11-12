#!/bin/bash

# Set the base mount directory
MOUNT_BASE="/run/media/$USER"

# Global variable to store the selected mount point
selected_mount_point=""

# List mount points and ask user to choose one to unmount
list_and_choose_mount_point() {
    echo "Mounted USB Drives:"

    local choices=()
    local count=0

    # List all mount points under the base directory
    for mountpoint in "$MOUNT_BASE"/*; do
        if [ -d "$mountpoint" ]; then
            choices+=("$mountpoint")
            count=$((count + 1))
            echo "$count) $mountpoint"
        fi
    done

    # Check if no mount points are found
    if [ $count -eq 0 ]; then
        echo "No mounted USB drives detected."
        return 1
    fi

    # Ask user to choose a mount point to unmount
    read -p "Enter the number of the mount point to unmount: " choice
    selected_mount_point=${choices[$((choice - 1))]}

    # Validate selection
    if [ -z "$selected_mount_point" ]; then
        echo "Invalid selection."
        selected_mount_point=""
    else
        echo "You selected: $selected_mount_point"
    fi
}

# Get the device corresponding to the mount point
get_device_for_mount() {
    local mountpoint=$1
    findmnt -n -o SOURCE --mountpoint "$mountpoint"
}

# Call the function to list and choose mount point
list_and_choose_mount_point

if [ -n "$selected_mount_point" ]; then
    selected_device=$(get_device_for_mount "$selected_mount_point")

    if [ -z "$selected_device" ]; then
        echo "Failed to find the device for $selected_mount_point."
        exit 1
    fi

    echo "Unmounting $selected_device..."

    # Unmount the selected device
    if udisksctl unmount -b "$selected_device"; then
        echo "$selected_device unmounted successfully."
    else
        echo "Failed to unmount $selected_device."
    fi
else
    echo "No mount point was unmounted."
fi
