#!/bin/bash

version='1.0'

utils_path="utils/"
inst_path="installation/"
pkg_path="${inst_path}packages/"
tpl_path="${inst_path}templates/"

# Load some utils that will be used in the scripts
source "${utils_path}utils.sh"
source "${utils_path}colors.sh"

# Check if the script is running with sudo privileges
#_checkSudo

# Check some packages before begin with the installation
source "${inst_path}before-installation.sh"

source "${utils_path}print-title.sh"

source "${inst_path}confirm-installation.sh"

source "${inst_path}yay.sh"

source "${inst_path}backup.sh"

source "${inst_path}preparation.sh"

source "${inst_path}installer.sh"

source "${inst_path}remove.sh"

source "${pkg_path}general-packages.sh"

source "${inst_path}install-packages.sh"

source "${pkg_path}hyprland-packages.sh"

source "${inst_path}install-packages.sh"

source "${inst_path}wallpapers.sh"

source "${inst_path}display-manager.sh"

source "${inst_path}restore.sh"

source "${inst_path}keyboard.sh"

source "${inst_path}copy.sh"

source "${inst_path}init-pywal.sh"

#source "${inst_path}hyprland-dotfiles.sh"

#source "${inst_path}gtk.sh"

source "${inst_path}bashrc.sh"

source "${inst_path}zshrc.sh"

source "${inst_path}cleanup.sh"

echo -e "${BLUE}"
figlet "Done"
echo -e "\n"

echo -e "${CYAN}"
echo "Please reboot your system!"
echo -e "${NOCOLOR}"
echo -e "\n"

sleep 3

