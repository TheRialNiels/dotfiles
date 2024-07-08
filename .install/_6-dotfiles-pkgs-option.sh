#!/usr/bin/env bash
# -----------------------------------------------------
# Dotfiles Packages Option
#
# This script prompts the user to choose between
# reinstalling all packages or installing new packages only.
# -----------------------------------------------------

## Print Dotfiles Packages Title
echo -e "${BLUE}"
figlet "Dotfiles Packages"
echo -e "${NOCOLOR}"

msg="HOW DO YOU WANT TO PROCEED?"

## Check if the ~/.dotfiles directory exists
if [ -d "$DOTFILES" ]; then
    # Prompt the user for package installation method
    _whiteText "::: =>  Do you want to check for new packages only (faster installation)"
    _whiteText "\tor do you want to reinstall all packages again? (more robust and can help to fix issues)?\n"

    if gum confirm "$msg" --affirmative "New packages only" --negative "Force reinstallation"; then
        _message "info" "Installing new packages only..."
        forceInstall=0
    elif [ $? -eq 130 ]; then
        _message "error" "Installation canceled!"
        exit 130
    else
        _message "info" "Reinstalling all packages..."
        forceInstall=1
    fi
else
    # Prompt the user for package installation method
    _whiteText "::: =>  Do you want to reinstall all already installed packages \n\tand install the required new packages? (recommended and more robust)"
    _whiteText "\tor do you want to install the new required packages only? (could be faster installation)?\n"

    if gum confirm "$msg" --affirmative "Reinstall all packages" --negative "Install new packages only"; then
        _message "info" "Reinstalling all packages..."
        forceInstall=1
    elif [ $? -eq 130 ]; then
        _message "error" "Installation canceled!"
        exit 130
    else
        _message "info" "Installing new packages only..."
        forceInstall=0
    fi
fi
