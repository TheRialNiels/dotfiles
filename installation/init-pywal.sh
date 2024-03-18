# ------------------------------------------------------
# init pywal with default wallpaper
# ------------------------------------------------------

if [ ! -f ~/.cache/wal/colors-hyprland.conf ]; then
    _installSymLink wal ~/.config/wal ~/dotfiles/wal/ ~/.config
    wal -i ~/dotfiles/wallpapers/default.jpg

    echo -e "${GREEN}"
    echo "Pywal and templates activated."
    echo -e "${NOCOLOR}"
    echo -e "\n"
else
    echo -e "${GREEN}"
    echo "Pywal already activated."
    echo -e "${NOCOLOR}"
    echo -e "\n"
fi

