#!/bin/bash

# ------------------------------------------------------
# Check if yay is installed
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "yay"
echo -e "${NOCOLOR}"

if sudo pacman -Qs yay >/dev/null; then
    _showInfoMsg "yay is already installed!"
else
    _showNormalMsg "yay is not installed. Starting the installation!"
    _installPackagesPacman "base-devel"

    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")

    _changeTextColor "$WHITE" "$temp_path"
    git clone https://aur.archlinux.org/yay-git.git ~/yay-git
    cd "$HOME/yay-git" || return
    makepkg -si
    cd "$temp_path" || return

    _showSuccessMsg "yay has been installed successfully"
fi
