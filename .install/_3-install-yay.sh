#!/usr/bin/env bash
# -----------------------------------------------------
# Install yay
#
# This script installs yay on the system.
# -----------------------------------------------------

## Print Install yay Title
echo -e "${BLUE}"
figlet "Install yay"
echo -e "${NOCOLOR}"

## Check if yay is already installed
if sudo pacman -Qs yay >/dev/null; then
    _message "info" "'yay' is already installed!"
else
    _message "info" "'yay is not installed'. Starting the installation..."
    _installPackagesWith "pacman" "base-devel"

    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")

    git clone https://aur.archlinux.org/yay-git.git ~/yay-git
    cd "$HOME/yay-git" || return
    makepkg -si
    cd "$temp_path" || return

    _message "success" "'yay' installed successfully!"
fi
