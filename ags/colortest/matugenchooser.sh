#!/bin/bash

# Define the source directory and the destination directory
source_dir="/home/niels/.config/ags/colortest"
destination_dir="/home/niels/.config/ags"
destination_file="$destination_dir/colors.json"

sleep 4

# Function to run matugenpicker
run_matugenpicker() {
    # Run hyprpicker and save the output, remove the first character, and store it in hexoutput
    hexoutput=$(hyprpicker | cut -c 2-)

    # Generate color JSON using matugen
    json_output=$(matugen color hex "$hexoutput" --json hex)

    # Define the output directory and file
    output_file="$source_dir/$1.json"

    # Save the JSON output to the file
    echo "$json_output" > "$output_file"
    echo "JSON color data saved to $output_file"

    # Copy the file to colors.json in the destination directory
    cp "$output_file" "$destination_file"
    echo "File '$1.json' copied and renamed to 'colors.json' in $destination_dir."
}

# Check if the file exists with .json extension
if [ -f "$source_dir/$1.json" ]; then
    # File exists, copy it to destination and rename
    cp "$source_dir/$1.json" "$destination_file"
    echo "File '$1.json' copied and renamed to 'colors.json' in $destination_dir."
else
    # File doesn't exist, run matugenpicker
    run_matugenpicker "$1"
fi