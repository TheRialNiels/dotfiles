#!/usr/bin/env bash
# -----------------------------------------------------
# Cleanup Installation
#
# This script cleans up the installation by removing
# unnecessary packages and enabling services.
# -----------------------------------------------------

echo -e "${BLUE}"
figlet "Cleanup"
echo -e "${NOCOLOR}"

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/general-utils.sh
source "$SCRIPTS_DIR/general-utils.sh"

# shellcheck source=../scripts/packages-utils.sh
source "$SCRIPTS_DIR/packages-utils.sh"

# shellcheck source=../scripts/folders-utils.sh
source "$SCRIPTS_DIR/folders-utils.sh"

## Check for ttf-ms-fonts
if [[ $(_checkIsInstalledWith "pacman" "ttf-ms-fonts") == 0 ]]; then
    _message "warning" "The script has detected ttf-ms-fonts. This can cause conflicts with icons in Waybar."

    msg="DO YOU WANT TO UNINSTALL ttf-ms-fonts?"
    if gum confirm "$msg"; then
        _removePackagesWith "pacman" "ttf-ms-fonts"
    fi
fi

## Source Required Services
# shellcheck source=../services/services.sh
source "$SERVICES_DIR/required-services.sh"

# Check or enable required services
# shellcheck disable=SC2154
for service in "${requiredServices[@]}"; do
    _enableServices "$service"
done

## Check if command to update xdg user directories exists
if command -v xdg-user-dirs-update &>/dev/null; then
    # Create default folders
    xdg-user-dirs-update
fi

## Create Screenshots directory if it doesn't exist
if command -v xdg-user-dir &>/dev/null; then
    PICTURES_DIR=$(xdg-user-dir PICTURES)
    _createDirectoryIfNotExists "$PICTURES_DIR/Screenshots"
fi
