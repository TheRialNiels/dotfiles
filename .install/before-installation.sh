#!/usr/bin/env bash

# ------------------------------------------------------
# Update /etc/pacman.conf file
# ------------------------------------------------------
_replaceLineInFile "#Color" "Color" "/etc/pacman.conf"
_replaceLineInFile "#ParallelDownloads = 5" "ParallelDownloads = 3" "/etc/pacman.conf"

# ------------------------------------------------------
# Pacman Key
# ------------------------------------------------------
sudo pacman-key --init

# ------------------------------------------------------
# Check for required packages to run the installation
# ------------------------------------------------------

# Synchronize packages
sudo pacman -Syu
echo -e "\n"

# Check for required packages
_showInfoMsg "Checking that required packages for the installation are installed..."
_installPackagesPacman "rsync" "gum" "figlet"

# Double check rsync
if ! command -v rsync &>/dev/null; then
    _showInfoMsg "Force rsync installation"
    sudo pacman -S --noconfirm rsync
else
    _showInfoMsg "rsync double checked"
fi
