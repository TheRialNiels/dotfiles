#!/bin/bash

version='1.0'

utils_path="utils/"
inst_path="installation/"
pkg_path="${inst_path}packages/"

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

