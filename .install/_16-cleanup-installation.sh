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

## Check for ttf-ms-fonts
if [[ $(_checkIsInstalledWith "pacman" "ttf-ms-fonts") == 0 ]]; then
    _message "warning" "The script has detected ttf-ms-fonts. This can cause conflicts with icons in Waybar."

    msg="DO YOU WANT TO UNINSTALL ttf-ms-fonts?"
    if gum confirm "$msg"; then
        _removePackagesWith "pacman" "ttf-ms-fonts"
    fi
fi

## Source Required Services
# shellcheck source=./services/required-services.sh
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

## Install Fluent Icons Theme if it doesn't exist
if [[ ! -d "$HOME/.local/share/icons/Fluent" ]]; then
    _message "info" "Installing Fluent Icons Theme..."
    git clone https://github.com/vinceliuice/Fluent-icon-theme.git /tmp/Fluent-icon-theme
    cd /tmp/Fluent-icon-theme || exit
    ./install.sh -a
    cd ..
    rm -rf /tmp/Fluent-icon-theme
    cd "$DOTFILES_SCRIPT_PATH" || exit
    _message "success" "Fluent Icons Theme installed."
fi

## Define Dotfiles Env Variabl
if [[ "$mode" == "dev" ]]; then
    _replaceLineNumberInFile "$DOTFILES_SCRIPT_PATH/dotfiles/zsh/.zshenv" "26" "export DOTFILES=$DOTFILES_SCRIPT_PATH/dotfiles"
else
    _replaceLineNumberInFile "$DOTFILES_SCRIPT_PATH/dotfiles/zsh/.zshenv" "26" "export DOTFILES=$HOME/dotfiles"
fi
