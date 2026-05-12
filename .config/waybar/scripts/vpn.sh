#!/bin/sh

STATUS=$(mullvad status)
TOOLTIP=$(printf '%s' "$STATUS" | sed 's/"/\\"/g' | tr '\n' ' ' | sed 's/ $//')

if printf '%s' "$STATUS" | grep -q 'Connected'; then
    printf '{"tooltip":"%s","text":"󰌾 VPN","class":"connected"}\n' "$TOOLTIP"
else
    printf '{"tooltip":"%s","text":"󰌿 No VPN","class":"disconnected"}\n' "$TOOLTIP"
fi
