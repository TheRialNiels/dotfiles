#!/bin/bash

# ------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "Wallpapers"
echo -e "${NOCOLOR}"

# ------------------------------------------------------
# Copy default wallpaper files to .cache
# ------------------------------------------------------

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/dotfiles/wallpapers/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/dotfiles/wallpapers/default.jpg\", height); }" > "$rasi_file"
fi

