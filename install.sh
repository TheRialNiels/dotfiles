#!/usr/bin/env bash

export VERSION="$(cat .version/version)"
export UTILS_PATH="./utils"
export INST_PATH="./.install"
export PKGS_PATH="$INST_PATH/packages"
export TMPL_PATH="$INST_PATH/templates"
export DOTFILES="$HOME/dotfiles"
export HYPR_CONF="$DOTFILES/hypr/conf"

# Load some utils that will be used in the scripts
source "$UTILS_PATH/utils.sh"
source "$UTILS_PATH/colors.sh"

# Check some packages before begin with the installation
source "${INST_PATH}/before-installation.sh"

source "${UTILS_PATH}/print-title.sh"

source "${INST_PATH}/confirm-installation.sh"

source "${INST_PATH}/yay.sh"

source "${INST_PATH}/backup.sh"

source "${INST_PATH}/preparation.sh"

source "${INST_PATH}/installer.sh"

source "${INST_PATH}/remove.sh"

source "${PKGS_PATH}/general-packages.sh"

source "${INST_PATH}/install-packages.sh"

source "${PKGS_PATH}/hyprland-packages.sh"

source "${INST_PATH}/install-packages.sh"

source "${INST_PATH}/zsh.sh"

source "${INST_PATH}/wallpapers.sh"

source "${INST_PATH}/keyboard.sh"

source "${INST_PATH}/copy.sh"

source "${INST_PATH}/dotfiles.sh"

source "${INST_PATH}/grub.sh"

source "${INST_PATH}/cleanup.sh"

echo -e "${BLUE}"
figlet "Done"

_showInfoMsg "Please reboot your system!"

sleep 3
