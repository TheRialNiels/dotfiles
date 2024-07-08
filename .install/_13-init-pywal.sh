#!/usr/bin/env bash
# -----------------------------------------------------
# Init Pywal
#
# This script initializes Pywal and sets the colorscheme
# -----------------------------------------------------

echo -e "${BLUE}"
figlet "Pywal"
echo -e "${NOCOLOR}"

## Check if Pywal is installed
if [ ! -f ~/.cache/wal/colors-hyprland.conf ]; then
    # Define the path of the folder
    case $mode in
    "dev")
        folderPath="$DOTFILES_SCRIPT_PATH/dotfiles/wal"
        ;;
    "prod")
        folderPath="$HOME/dotfiles/wal"
        ;;
    esac

    _createSymlink "$HOME/.config/wal" "$folderPath/" "$HOME/.config"
    wal -q -n -s -t -e -i $DOTFILES/wallpapers/default.jpg
    _message "info" "'Pywal' activated."
else
    _message "info" "'Pywal' already activated."
fi
