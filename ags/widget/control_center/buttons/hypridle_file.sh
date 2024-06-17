#!/bin/bash

# Define the file path
FILE="/home/niels/.config/hypr/hypridle.conf"

# Define the timeout values in order
TIMEOUT_VALUES=(60 120 300 600)

# Read current timeout value from the file
CURRENT_TIMEOUT=$(grep -Po '^ *timeout = \K\d+' "$FILE")
echo $CURRENT_TIMEOUT
# Find index of current timeout value in TIMEOUT_VALUES array
for ((i=0; i<${#TIMEOUT_VALUES[@]}; i++)); do
    if [[ ${TIMEOUT_VALUES[i]} -eq $CURRENT_TIMEOUT ]]; then
        NEW_INDEX=$(( (i + 1) % ${#TIMEOUT_VALUES[@]} ))
        NEW_TIMEOUT=${TIMEOUT_VALUES[NEW_INDEX]}
        break
    fi
done
echo $NEW_TIMEOUT

# Replace timeout value in the file using awk
awk -v new_timeout="$NEW_TIMEOUT" '
    /^ *timeout = / && !changed {
        $3 = new_timeout
        changed = 1
    }
    { print }
' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
notify-send "Timeout: $NEW_TIMEOUT s"

killall hypridle
hypridle