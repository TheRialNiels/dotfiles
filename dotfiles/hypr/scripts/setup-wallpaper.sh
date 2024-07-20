#!/usr/bin/env bash

# -----------------------------------------------------
# Setup Wallpaper
# -----------------------------------------------------

## Define Variables
cacheWall="$HOME/.cache/wallpaper/current_wallpaper"
wallpaper=$(cat "$cacheWall")

if [ -f "$wallpaper" ]; then
    transition_type="wipe"
    # transition_type="outer"
    # transition_type="random"

    swww img "$wallpaper" \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=0.7 \
        --transition-pos "$(hyprctl cursorpos)"

else
    notify-send "Wallpaper '$wallpaper' not found."
fi
