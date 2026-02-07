#!/bin/bash

# Files
advice_cache="$HOME/dotfiles/.cache/.advice_cache"
advice_time_file="$HOME/dotfiles/.cache/.advice_timestamp"

# Check if Spotify is running and has metadata
if pgrep -x "spotify" > /dev/null && playerctl -p spotify metadata title &>/dev/null; then
    song=$(playerctl -p spotify metadata title 2>/dev/null)
    artist=$(playerctl -p spotify metadata artist 2>/dev/null)

    if [[ -n "$song" && -n "$artist" ]]; then
        echo "$artist - $song"
    fi
else
    # Spotify is NOT playing - Handle Advice Logic
    current_time=$(date +%s)
    last_update=$(cat "$advice_time_file" 2>/dev/null || echo 0)
    
    # 1800 seconds = 30 minutes
    if (( current_time - last_update > 1800 )) || [ ! -f "$advice_cache" ]; then
        new_advice=$(curl -s "https://api.adviceslip.com/advice" | jq -r '.slip.advice')
        
        # Only update if the API call was successful
        if [[ -n "$new_advice" && "$new_advice" != "null" ]]; then
            echo "$new_advice" > "$advice_cache"
            echo "$current_time" > "$advice_time_file"
        fi
    fi

    # Output the cached advice only
    if [ -f "$advice_cache" ]; then
        cat "$advice_cache"
    fi
fi