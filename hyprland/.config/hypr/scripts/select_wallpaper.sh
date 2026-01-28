#!/bin/bash

# Set the directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/.config/images/backgrounds/"

# Use 'find' to get a list of wallpaper filenames and present them with Rofi
# -printf "%f\n" tells find to print only the filename followed by a newline.
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -printf "%f\n" | \
rofi -dmenu -i -p "Select Wallpaper")

# If the user selected a wallpaper (i.e., didn't cancel)
if [ -n "$SELECTED_WALLPAPER" ]; then
    # Construct the full path to the selected wallpaper
    FULL_PATH="${WALLPAPER_DIR}${SELECTED_WALLPAPER}"

    # Use the 'reload' command with the full path to set the new wallpaper
    echo $FULL_PATH
    wal -i "$FULL_PATH"
    swww img $FULL_PATH --transition-type=wipe --transition-fps=60 --transition-duration=0.6
    ~/.config/waybar/scripts/restart.sh
fi
