#!/bin/bash

# Get Mullvad VPN status and escape double quotes
STATUS=$(/usr/bin/mullvad status | /usr/bin/sed 's/\"/\\\"/g')

# Replace newline characters with '\n' for JSON formatting
FORMATTED_STATUS=$(echo "$STATUS" | /usr/bin/sed ':a;N;$!ba;s/\n/\\n/g')

# Create JSON output based on VPN status
if echo "$STATUS" | /usr/bin/grep -q 'Connected'; then
    OUTPUT="{\"tooltip\": \"$FORMATTED_STATUS\", \"text\": \"✔ VPN\"}"
else
    OUTPUT="{\"tooltip\": \"$FORMATTED_STATUS\", \"text\": \"⚠ No VPN\", \"class\": \"disconnected\"}"
fi

echo "$OUTPUT"

