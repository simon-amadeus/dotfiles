#!/bin/sh
#
# Executed by systemd timer/service
#

# Define the package list paths
PKGLIST="$HOME/.config/packages/pkglist.txt"
AURPKGLIST="$HOME/.config/packages/aur_pkglist.txt"

# Define your git directory for dotfiles
DOTFILES_GIT_DIR="$HOME/.dotfiles"
GIT_WORK_TREE="$HOME"

# Create the package lists
pacman -Qqetn > "$PKGLIST"
pacman -Qqetm > "$AURPKGLIST"

# Perform git operations using the specific directories
/usr/bin/git --git-dir="$DOTFILES_GIT_DIR" --work-tree="$GIT_WORK_TREE" add "$PKGLIST" "$AURPKGLIST"
/usr/bin/git --git-dir="$DOTFILES_GIT_DIR" --work-tree="$GIT_WORK_TREE" diff-index --quiet HEAD || /usr/bin/git --git-dir="$DOTFILES_GIT_DIR" --work-tree="$GIT_WORK_TREE" commit -m "Update package lists"

# Push changes - optional, remove the next line if you don't want to automatically push
/usr/bin/git --git-dir="$DOTFILES_GIT_DIR" --work-tree="$GIT_WORK_TREE" push

