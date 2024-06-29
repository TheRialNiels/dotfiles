#!/usr/bin/env bash
# -----------------------------------------------------
# Check Existing Packages
#
# This script checks if some packages are already installed
# to uninstall them before installing the new ones.
# -----------------------------------------------------

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/packages-utils.sh
source "$SCRIPTS_DIR/packages-utils.sh"

## Remove Rofi
if [[ $(_checkIsInstalledWith "pacman" "rofi") == 0 ]]; then
    sudo pacman -Rns rofi --noconfirm
    _message "info" "Rofi uninstalled"
fi

## Remove hypridle
if [[ $(_checkIsInstalledWith "yay" "hypridle") == 0 ]]; then
    yay -Rns hypridle --noconfirm

    if [ -f /usr/lib/debug/usr/bin/hypridle.debug ]; then
        sudo rm /usr/lib/debug/usr/bin/hypridle.debug
        _message "info" "'/usr/lib/debug/usr/bin/hypridle.debug' removed"
    fi

    _message "info" "'hypridle' uninstalled"
    _message "success" "'hypridle' can be installed again"
fi

## Remove hyprlock
if [[ $(_checkIsInstalledWith "yay" "hyprlock") == 0 ]]; then
    yay -Rns hyprlock --noconfirm

    if [ -f /usr/lib/debug/usr/bin/hyprlock.debug ]; then
        sudo rm /usr/lib/debug/usr/bin/hyprlock.debug
        _message "info" "'/usr/lib/debug/usr/bin/hyprlock.debug' removed"
    fi

    _message "info" "'hyprlock' uninstalled"
    _message "success" "'hyprlock' can be installed again"
fi
