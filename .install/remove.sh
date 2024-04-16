#!/usr/bin/env bash

# Remove hypridle-bin
if [[ $(_isInstalledYay "hypridle-git") == 0 ]]; then
    yay --noconfirm -Rns hypridle-git
    if [ -f /usr/lib/debug/usr/bin/hypridle.debug ]; then
        sudo rm /usr/lib/debug/usr/bin/hypridle.debug
        _showInfoMsg "$(_changeTextWhite "/usr/lib/debug/usr/bin/hypridle.debug") removed"
    fi
    _showInfoMsg "$(_changeTextWhite "hypridle-git") uninstalled"
    _showInfoMsg "$(_changeTextWhite "hypridle-git") can now be installed"
fi

# Remove hyprlock-bin
if [[ $(_isInstalledYay "hyprlock-git") == 0 ]]; then
    yay --noconfirm -Rns hyprlock-git
    if [ -f /usr/lib/debug/usr/bin/hyprlock.debug ]; then
        sudo rm /usr/lib/debug/usr/bin/hyprlock.debug
        _showInfoMsg "$(_changeTextWhite "/usr/lib/debug/usr/bin/hyprlock.debug") removed"
    fi
    _showInfoMsg "$(_changeTextWhite "hyprlock-git") uninstalled"
    _showInfoMsg "$(_changeTextWhite "hyprlock-git") can now be installed"
fi
