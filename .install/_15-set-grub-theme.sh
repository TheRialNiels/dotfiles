#!/usr/bin/env bash
# -----------------------------------------------------
# Set Grub Theme
#
# This script installs the Vimix Grub theme.
# -----------------------------------------------------

echo -e "${BLUE}"
figlet "Grub"
echo -e "${NOCOLOR}"

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

## Variables
REPO_URL="https://github.com/vinceliuice/grub2-themes.git"
THEME_NAME="vimix"
THEMES_DIR="$HOME/grub2-themes"

## Check if the theme is already installed
if [ -d "$THEMES_DIR" ]; then
    _message "info" "The Grub theme '$THEME_NAME' is already installed."
    exit 0 # Exit with success code
fi

## Clone the repository
if git clone "$REPO_URL" "$THEMES_DIR"; then
    cd "$THEMES_DIR" || {
        _message "error" "Failed to change directory to '$THEMES_DIR'"
        exit 1 # Exit with error code
    }

    sudo ./install.sh -t "$THEME_NAME" || {
        _message "error" "Failed to install grub theme"
        exit 1 # Exit with error code
    }
else
    _message "error" "Failed to clone the repository '$REPO_URL'"
    exit 1 # Exit with error code
fi
