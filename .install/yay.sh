#!/bin/bash

# ------------------------------------------------------
# Check if yay is installed
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "yay"
echo -e "${NOCOLOR}"

if sudo pacman -Qs yay > /dev/null ; then
    echo -e "${CYAN}"
    echo ":: yay is already installed!"
    echo -e "${NOCOLOR}"
else
    echo ":: yay is not installed. Starting the installation!"
    _installPackagesPacman "base-devel"

    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")

    echo $temp_path
    git clone https://aur.archlinux.org/yay-git.git ~/yay-git
    cd ~/yay-git
    makepkg -si
    cd $temp_path

    echo -e "${GREEN}"
    echo ":: yay has been installed successfully."
    echo -e "${NOCOLOR}"
fi

echo -e "\n"

