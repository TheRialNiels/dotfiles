#!/bin/bash

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
sudo pacman -Sy
echo -e "\n"

# Check for required packages
echo -e ":: Checking that required packages for the installation are installed...\n"
_installPackagesPacman "rsync" "gum" "figlet"

# Double check rsync
if ! command -v rsync &> /dev/null; then
    echo ":: Force rsync installation"
    sudo pacman -S --noconfirm rsync
else
    echo ":: rsync double checked"
fi
echo -e "\n"

