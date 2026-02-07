#!/bin/bash

# Settings
SQUARE_SIZE=500
RADIUS=50         
BLUR_STRENGTH=10  
OPACITY=10        
OUTPUT_PATH="$HOME/dotfiles/.cache/lockpaper.png"

# 1. Check if an input file was provided
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/image.jpg"
    exit 1
fi

INPUT_IMG="$1"

# 2. Check if the file actually exists
if [ ! -f "$INPUT_IMG" ]; then
    echo "Error: File '$INPUT_IMG' not found."
    exit 1
fi

# Check for ImageMagick 7 (magick) or fallback to ImageMagick 6 (convert)
CMD="magick"
if ! command -v $CMD &> /dev/null; then
    CMD="convert"
fi

echo "Creating glass effect for: $INPUT_IMG"

$CMD "$INPUT_IMG" -thumbnail 'x1080' \( \
    -clone 0 \
    -blur 0x$BLUR_STRENGTH \
    -fill "white" -colorize $OPACITY \
    -gravity center -extent ${SQUARE_SIZE}x${SQUARE_SIZE} \
    \( -size ${SQUARE_SIZE}x${SQUARE_SIZE} xc:black -fill white \
       -draw "roundrectangle 0,0 $SQUARE_SIZE,$SQUARE_SIZE $RADIUS,$RADIUS" \) \
    -alpha off -compose copy_opacity -composite \
\) -gravity center -compose over -composite "$OUTPUT_PATH"

echo "Done! Saved to $OUTPUT_PATH"