#!/bin/bash
# Executed by the sync-pkglist.service systemd user unit.
#
# Writes the explicitly installed packages to the dotfiles repo, minus
# everything arch-install already ensures (baseline.txt) — so the lists
# stay a curated delta of what was installed by hand.

PKGDIR="$HOME/.config/packages"
PKGLIST="$PKGDIR/pkglist.txt"
AURPKGLIST="$PKGDIR/aur_pkglist.txt"
BASELINE="$PKGDIR/baseline.txt"
DOTFILES_GIT="$HOME/.dotfiles"
GIT="git --git-dir=$DOTFILES_GIT --work-tree=$HOME"

fail() { notify-send -u critical "Package sync" "$1"; exit 1; }

[ -d "$DOTFILES_GIT" ] || fail "Dotfiles git dir $DOTFILES_GIT not found."
[ -f "$BASELINE" ] || fail "Baseline list $BASELINE not found."

# grep -v exits 1 when everything is filtered out; only pacman failures matter.
subtract_baseline() { grep -vxF -f <(grep -v '^#' "$BASELINE"); }

pacman -Qqen | subtract_baseline > "$PKGLIST"
[ "${PIPESTATUS[0]}" -eq 0 ] || fail "Failed to generate package list."

pacman -Qqem | subtract_baseline > "$AURPKGLIST"
[ "${PIPESTATUS[0]}" -eq 0 ] || fail "Failed to generate AUR list."

$GIT add "$PKGLIST" "$AURPKGLIST" || fail "Failed to stage package lists."

if ! $GIT diff-index --quiet HEAD; then
    $GIT commit -m "chore: update package lists" || fail "Failed to commit."
fi

# Push non-fatally — may fail if offline.
$GIT push || notify-send -u normal "Package sync" "Committed but push failed (offline?)"
