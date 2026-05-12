#!/bin/bash
# Executed by the sync-pkglist.service systemd user unit.

PKGLIST="$HOME/.config/packages/pkglist.txt"
AURPKGLIST="$HOME/.config/packages/aur_pkglist.txt"
DOTFILES_GIT="$HOME/.dotfiles"
GIT="git --git-dir=$DOTFILES_GIT --work-tree=$HOME"

fail() { notify-send -u critical "Package sync" "$1"; exit 1; }

[ -d "$DOTFILES_GIT" ] || fail "Dotfiles git dir $DOTFILES_GIT not found."

pacman -Qqen > "$PKGLIST" || fail "Failed to generate package list."
pacman -Qqem > "$AURPKGLIST" || fail "Failed to generate AUR list."

$GIT add "$PKGLIST" "$AURPKGLIST" || fail "Failed to stage package lists."

if ! $GIT diff-index --quiet HEAD; then
    $GIT commit -m "Update package lists" || fail "Failed to commit."
fi

# Push non-fatally — may fail if offline.
$GIT push || notify-send -u normal "Package sync" "Committed but push failed (offline?)"
