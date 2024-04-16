#!/usr/bin/env bash

# ------------------------------------------------------
# Copy default wallpaper files to .cache
# ------------------------------------------------------

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f "$cache_file" ]; then
    touch "$cache_file"
    echo "$DOTFILES/wallpapers/default.jpg" >"$cache_file"
    _showSuccessMsg "Cache file for default wallpaper created"
fi

# Create rasi file if not exists
if [ ! -f "$rasi_file" ]; then
    touch "$rasi_file"
    echo "* { current-image: url(\"$DOTFILES/wallpapers/default.jpg\", height); }" >"$rasi_file"
    _showSuccessMsg "Cache file for default rasi wallpaper created"
fi
