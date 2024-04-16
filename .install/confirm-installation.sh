#!/bin/bash

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

_showImportantMsg "Please make sure that your system and your packages are up to date (sudo pacman -Syu or yay)"
_showImportantMsg "You can cancel the installation at any time with CTRL + C"
_showImportantMsg "If you have already installed a window manager like sway, please backup your .config folder"

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ $SCRIPTPATH = "$DOTFILES" ]; then
    _showImportantMsg "You're running the installation script from the installation target directory"
    _showInfoMsg "Please move the installation folder dotfiles e.g. to ~/Downloads/ and start the script again"
    _showWarningMsg "Proceeding is not recommended!"
fi

if [ ! -d "$DOTFILES" ]; then
    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO START THE INSTALLATION NOW?" --default=false; then
        _showNormalMsg "Installation started"
    elif [ $? -eq 130 ]; then
        exit 130
    else
        _showNormalMsg "Installation canceled"
        exit
    fi
else
    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO START THE UPDATE NOW?" --default=false; then
        _showNormalMsg "Update started"
    elif [ $? -eq 130 ]; then
        exit 130
    else
        _showNormalMsg "Update canceled"
        exit
    fi
fi
