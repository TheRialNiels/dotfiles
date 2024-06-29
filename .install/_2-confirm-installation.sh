#!/usr/bin/env bash
# -----------------------------------------------------
# Confirm Installation
#
# This script asks the user if they want to start the
# installation or update the dotfiles.
# -----------------------------------------------------

# shellcheck source=../scripts/source-utils.sh
source "$SCRIPTS_DIR/source-utils.sh"

_message "important" "Please make sure that your system and your packages are up to date ('sudo pacman -Syu' or 'yay')"
_message "important" "You can cancel the installation at any time with 'CTRL + C'"

## Check if the script is running from dotfiles folder
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ "$SCRIPTPATH" = "$DOTFILES" ]; then
    _message "important" "You're running the installation script from the installation target directory"
    _message "important" "Please move the installation folder dotfiles e.g. to ~/Downloads/ and start the script again"
    _message "warn" "Proceeding is not recommended!"
fi

## Check if the dotfiles folder already exists
if [ ! -d "$DOTFILES" ]; then
    msg="DO YOU WANT TO START THE INSTALLATION?"
    if gum confirm "$msg" --default=false; then
        _message "info" "Starting installation..."
    else
        _message "info" "Installation canceled!"
        exit 0
    fi
else
    msg="DO YOU WANT TO UPDATE THE DOTFILES?"
    if gum confirm "$msg" --default=false; then
        _message "info" "Starting update..."
    else
        _message "info" "Update canceled!"
        exit 0
    fi
fi
