#!/usr/bin/env bash
# -----------------------------------------------------
# Install General Packages
#
# This script installs the general packages.
# -----------------------------------------------------

# shellcheck source=./packages/general-packages.sh
source "$PACKAGES_DIR/general-packages.sh"

# shellcheck source=./packages/hyprland-packages.sh
source "$PACKAGES_DIR/hyprland-packages.sh"

# shellcheck source=./packages/python-packages.sh
source "$PACKAGES_DIR/python-packages.sh"

## Print Install Python Packages Title
echo -e "${BLUE}"
figlet "Python Packages"
echo -e "${NOCOLOR}"

## Install Python Packages
_message "info" "Installing python packages..."

## Check forceInstall flag
if [[ "$forceInstall" == "1" ]]; then
    _message "info" "Forcing installation of packages..."
    _installPackagesWith "pip" "${pythonPackagesPip[@]}"
else
    _message "info" "Installing only missing packages..."
    _installPackagesWith "pip" "${pythonPackagesPip[@]}"
fi

_message "success" "Python packages installed."

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
    _installPackagesWith "yay" "${generalPackagesYay[@]}"
else
    _message "info" "Installing only missing packages..."
    _installPackagesWith "pacman" "${generalPackagesPacman[@]}"
    _installPackagesWith "yay" "${generalPackagesYay[@]}"
fi

_message "success" "General packages installed."

## Print Install Hyprland Packages Title
echo -e "${BLUE}"
figlet "Hyprland Packages"
echo -e "${NOCOLOR}"

## Install Hyprland Packages
_message "info" "Installing hyprland packages..."

## Check forceInstall flag
if [[ "$forceInstall" == "1" ]]; then
    _message "info" "Forcing installation of packages..."
    _installPackagesWith "pacman" "${hyprlandPackagesPacman[@]}"
    _installPackagesWith "yay" "${hyprlandPackagesYay[@]}"
else
    _message "info" "Installing only missing packages..."
    _installPackagesWith "pacman" "${hyprlandPackagesPacman[@]}"
    _installPackagesWith "yay" "${hyprlandPackagesYay[@]}"
fi

_message "success" "Hyprland packages installed."
