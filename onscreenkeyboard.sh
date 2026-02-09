source ~/.cache/wal/colors.sh

darken() {
    local hex=${1/#\#/}
    local percent=$2
    
    # Split R, G, and B
    local r_dec=$(printf "%d" 0x${hex:0:2})
    local g_dec=$(printf "%d" 0x${hex:2:2})
    local b_dec=$(printf "%d" 0x${hex:4:2})
    
    # Multiply by percentage (using bc for math)
    local r_new=$(echo "$r_dec * $percent / 100" | bc)
    local g_new=$(echo "$g_dec * $percent / 100" | bc)
    local b_new=$(echo "$b_dec * $percent / 100" | bc)
    
    # Convert back to 2-digit Hex
    printf "%02x%02x%02x" $r_new $g_new $b_new
}

ALPHA="E6"
BG="${background/#\#/}00"
FG=$(darken $color11 70)$ALPHA
PR=$(darken $color1 70)$ALPHA

pkill -f wvkbd-deskintl || ~/dotfiles/wvkbd-deskintl --bg $BG --fg $FG --fg-sp $PR --text ffffff