#!/usr/bin/env bash

# ------------------------------------------------------
# Install tty login and issue
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "Cleanup"
echo -e "${NOCOLOR}"

# Check for ttf-ms-fonts
if [[ $(_isInstalledPacman "ttf-ms-fonts") == 0 ]]; then
    _showWarningMsg "The script has detected ttf-ms-fonts. This can cause conflicts with icons in Waybar"

    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO UNINSTALL ttf-ms-fonts?"; then
        sudo pacman --noconfirm -R ttf-ms-fonts
    fi
    echo -e "${NOCOLOR}"
fi

# Check for running NetworkManager.service
if [[ $(systemctl list-units --all -t service --full --no-legend "NetworkManager.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "NetworkManager.service" ]]; then
    _showInfoMsg "NetworkManager.service already running"
else
    sudo systemctl enable NetworkManager.service
    sudo systemctl start NetworkManager.service
    _showSuccessMsg "NetworkManager.service activated successfully"
fi

# Check for running bluetooth.service
if [[ $(systemctl list-units --all -t service --full --no-legend "bluetooth.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "bluetooth.service" ]]; then
    _showInfoMsg "bluetooth.service already running"
else
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
    _showSuccessMsg "bluetooth.service activated successfully"
fi

# Create default folder structure
xdg-user-dirs-update

echo -e "\n${BLUE}"
echo "Cleanup done."
echo -e "${NOCOLOR}\n"
