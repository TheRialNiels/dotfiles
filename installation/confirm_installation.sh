#!/bin/bash

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

echo -e "${CYAN}"
echo "IMPORTANT: Please make sure that your system and your packages are up to date (sudo pacman -Syu or yay)."
echo "You can cancel the installation at any time with CTRL + C"
echo "If you have already installed a window manager like sway, please backup your .config folder."

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ $SCRIPTPATH = "/home/$USER/dotfiles" ]; then
    echo ""
    echo "IMPORTANT: You're running the installation script from the installation target directory."
    echo "Please move the installation folder dotfiles e.g. to ~/Downloads/ and start the script again."
    echo -e "${YELLOW}"
    echo "Proceeding is not recommended!"
fi

echo $GUM_CONFIRM_SELECTED_FOREGROUND

if [ ! -d ~/dotfiles ];then
    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO START THE INSTALLATION NOW?" ;then
echo -e "${NOCOLOR}"
        echo "Installation started."
    elif [ $? -eq 130 ]; then
            exit 130
    else
	echo -e "${NOCOLOR}"
        echo "Installation canceled."
        exit;
    fi
else
    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO START THE UPDATE NOW?" ;then
	echo -e "${NOCOLOR}"
        echo "Update started."
    elif [ $? -eq 130 ]; then
            exit 130
    else
	echo -e "${NOCOLOR}"
        echo "Update canceled."
        exit;
    fi
fi

echo -e "\n"

