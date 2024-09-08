#!/bin/bash
#
# Executed by systemd timer/service
#

# Set the correct HOME directory
HOME="/home/knowone"

# Define the package list paths
PKGLIST="$HOME/.config/packages/pkglist.txt"
AURPKGLIST="$HOME/.config/packages/aur_pkglist.txt"

# Define your git directory for dotfiles
DOTFILES_GIT_DIR="$HOME/.dotfiles"
GIT_WORK_TREE="$HOME"

# Define notification command
notify_fail() {
    notify-send -u critical "Error while syncing package list" "$1"
}

# Ensure the Git repository exists
if [ ! -d "$DOTFILES_GIT_DIR" ]; then
    notify_fail "Git directory $DOTFILES_GIT_DIR does not exist."
    exit 1
fi

# Define git command with the proper work-tree and git-dir options
GIT_CMD="git --git-dir=$DOTFILES_GIT_DIR --work-tree=$GIT_WORK_TREE"

# Create the package lists
if ! pacman -Qqen > "$PKGLIST"; then
    notify_fail "Failed to create package list."
    exit 1
fi

if ! pacman -Qqem > "$AURPKGLIST"; then
    notify_fail "Failed to create AUR package list."
    exit 1
fi

# Add the updated package lists to git
if ! $GIT_CMD add "$PKGLIST" "$AURPKGLIST"; then
    notify_fail "Failed to add files to git."
    exit 1
fi

# Check for changes and commit if necessary
if ! $GIT_CMD diff-index --quiet HEAD; then
    if ! $GIT_CMD commit -m "Update package lists"; then
        notify_fail "Failed to commit changes."
        exit 1
    fi
fi

# Push changes (optional, can be removed)
if ! $GIT_CMD push; then
    notify_fail "Failed to push changes to remote repository."
    exit 1
fi

