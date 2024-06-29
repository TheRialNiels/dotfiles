#!/usr/bin/env bash
# -----------------------------------------------------
# Install General Packages
#
# This script installs the general packages.
# -----------------------------------------------------

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/packages-utils.sh
source "$SCRIPTS_DIR/packages-utils.sh"

# shellcheck source=./packages/general-packages.sh
source "$PACKAGES_DIR/general-packages.sh"

## Print Install General Packages Title
echo -e "${BLUE}"
figlet "General Packages"
echo -e "${NOCOLOR}"

## Install General Packages
_message "info" "Installing general packages..."

## Check forceInstall flag
if [[ "$forceInstall" == "1" ]]; then
    _message "info" "Forcing installation of packages..."
    _installPackagesWith "pacman" "${generalPackagesPacman[@]}"
    #_installPackagesWith "yay" "${generalPackagesYay[@]}"
else
    _message "info" "Installing only missing packages..."
    _installPackagesWith "pacman" "${generalPackagesPacman[@]}"
    #_installPackagesWith "yay" "${generalPackagesYay[@]}"
fi

_message "success" "General packages installed."
