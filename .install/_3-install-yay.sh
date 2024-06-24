#!/usr/bin/env bash
# -----------------------------------------------------
# Install yay
#
# This script installs yay on the system.
#
# Made by TheRialNiels
# -----------------------------------------------------

# shellcheck source=../scripts/source-utils.sh
source "$SCRIPTS_DIR/source-utils.sh"

echo -e "${BLUE}"
figlet "Install yay"
echo -e "${NOCOLOR}"

if sudo pacman -Qs yay >/dev/null; then
    _message "info" "'yay' is already installed!"
else
    _message "info" "'yay is not installed'. Starting the installation..."
    _installPackagesWithPacman "base-devel"

    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")

    git clone https://aur.archlinux.org/yay-git.git ~/yay-git
    cd "$HOME/yay-git" || return
    makepkg -si
    cd "$temp_path" || return

    _message "success" "'yay' installed successfully!"
fi