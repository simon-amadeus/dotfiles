#!/bin/bash
# Executed by the pkg-drift.service systemd user unit.
#
# Compares installed packages against the hand-curated manifests in
# ~/.config/packages and reports drift via notification and stdout
# (journal). Never writes the manifests — declaring a package is always
# a deliberate edit + commit.
#
# Excluded from the comparison (owned by arch-install, not the manifests):
# the knowone-* metas and their dependencies, base, kernel/firmware/
# microcode, and paru.

PKGDIR="$HOME/.config/packages"
PKGLIST="$PKGDIR/pkglist.txt"
AURPKGLIST="$PKGDIR/aur_pkglist.txt"
STRUCTURAL='^(knowone-|base$|linux|.*-ucode$|paru$)'

notify() { printf '%s\n%s\n' "$1" "$2"; notify-send -u "$3" "$1" "$2" 2>/dev/null; }

for f in "$PKGLIST" "$AURPKGLIST"; do
    [ -f "$f" ] || { notify "Package drift" "Manifest $f not found." critical; exit 1; }
done

installed=$({ pacman -Qqen; pacman -Qqem; } | grep -Ev "$STRUCTURAL" | sort -u)
declared=$(sort -u "$PKGLIST" "$AURPKGLIST")

undeclared=$(comm -23 <(printf '%s\n' "$installed") <(printf '%s\n' "$declared"))
missing=$(comm -13 <(printf '%s\n' "$installed") <(printf '%s\n' "$declared"))

report=""
[ -n "$undeclared" ] && report="Installed but not declared:"$'\n'"$undeclared"
[ -n "$missing" ] && report="${report:+$report$'\n\n'}Declared but not installed:"$'\n'"$missing"

if [ -n "$report" ]; then
    notify "Package drift" "$report" normal
else
    echo "No package drift."
fi
