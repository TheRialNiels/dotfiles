#!/bin/bash

# ------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "Wallpapers"
echo -e "${NOCOLOR}"

if [ ! -d ~/wallpaper ]; then
    wget -P ~/Downloads/ https://github.com/TheRialNiels/wallpapers/archive/refs/heads/main.zip
    unzip -o ~/Downloads/main.zip -d ~/Downloads/

    if [ ! -d ~/wallpaper/ ]; then
        mkdir ~/wallpaper
    fi

    cp ~/Downloads/wallpapers-main/* ~/wallpaper/

    rm -r ~/Downloads/wallpapers-main/
    rm ~/Downloads/main.zip

    echo -e "${CYAN}"
    echo "Wallpapers from the repository installed successfully."
    echo -e "${NOCOLOR}"
else
    echo -e "${CYAN}"
    echo ":: ~/wallpaper folder already exists."
    echo -e "${NOCOLOR}"
fi
echo -e "\n"

# ------------------------------------------------------
# Copy default wallpaper files to .cache
# ------------------------------------------------------

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpaper/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpaper/default.jpg\", height); }" > "$rasi_file"
fi

