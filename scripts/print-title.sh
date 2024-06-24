#!/usr/bin/env bash
# -----------------------------------------------------
# Print Title
#
# This script prints the title of the dotfiles.
#
# Made by TheRialNiels
# -----------------------------------------------------

clear

echo -e "${BLUE}"
figlet -f slant -t -c "HYPRLAND DOTFILES"

echo -e "${WHITE}"
figlet -f small -t -c "VERSION " "$VERSION"

figlet -f small -t -c "BY  THE  RIAL  NIELS"
echo -e "${NOCOLOR}"
