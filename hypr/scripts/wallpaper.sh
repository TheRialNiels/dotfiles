#!/bin/bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## Set Wallpaper in Hyprland

CACHE_WALL="$HOME/.cache/current_wallpaper"
WALLPAPER=$(cat "$CACHE_WALL")

# -----------------------------------------------------
# Set the new wallpaper
# -----------------------------------------------------
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

swww img $WALLPAPER \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"
