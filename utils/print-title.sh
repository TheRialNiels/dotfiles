#!/bin/bash

# ------------------------------------------------------
# Print the title of the script
# ------------------------------------------------------

clear

echo -e "${BLUE}"
figlet -f slant -t -c "HYPRLAND DOTFILES"

# Ascii Font -> Mini
echo -e "${WHITE}"
figlet -f small -t -c "VERSION" $version

figlet -f small -t -c "BY THE RIAL NIELS"
echo -e "${NOCOLOR}"

