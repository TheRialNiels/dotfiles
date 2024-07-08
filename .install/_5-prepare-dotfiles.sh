#!/usr/bin/env bash
# -----------------------------------------------------
# Prepare Dotfiles
#
# This script prepares the dotfiles for installation.
# -----------------------------------------------------

## Print Prepare Dotfiles Title
echo -e "${BLUE}"
figlet "Prepare Dotfiles"
echo -e "${NOCOLOR}"

## Check if .config directory exists, create it if it doesn't
if [ -d "$HOME/.config" ]; then
    _message "info" "The '.config/' folder already exists."
else
    mkdir "$HOME/.config"
    _message "success" "The '.config/' folder was created successfully."
fi

_message "info" "Preparing temporary folders for the installation"

## Create dotfiles-versions directory if it doesn't exist
if [ ! -d "$HOME/dotfiles-versions" ]; then
    mkdir "$HOME/dotfiles-versions"
    _message "success" "The 'dotfiles-versions/' folder was created successfully."
fi

## Create version-specific directory, handle existing directory
if [ ! -d "$HOME/dotfiles-versions/$VERSION" ]; then
    mkdir "$HOME/dotfiles-versions/$VERSION"
    _message "success" "The 'dotfiles-versions/$VERSION' folder was created successfully."
else
    _message "info" "The folder 'dotfiles-versions/$VERSION' already exists from previous installations."
    rm -rf "$HOME/dotfiles-versions/$VERSION"
    mkdir "$HOME/dotfiles-versions/$VERSION"
    _message "success" "The 'dotfiles-versions/$VERSION' folder was created successfully."
    _message "info" "Clean build prepared for the installation"
fi

## Synchronize files using rsync
rsync -a -I --exclude-from="$INST_PATH/.excludes" . "$HOME/dotfiles-versions/$VERSION/"

## Check if rsync succeeded and directory is not empty
if [[ $(_isFolderEmpty "$HOME/dotfiles-versions/$VERSION/") == 1 ]]; then
    _message "error" "Preparation of ' ~/dotfiles-versions/$VERSION' failed"
    _message "warn" "Please check that 'rsync' is installed on your system"
    exit 1 # Return error
fi

## Create a python virtual environment
if [ ! -d "$HOME/venv" ]; then
    python3 -m venv "$HOME/venv"
    _message "success" "Python virtual environment created successfully"

    ## Activate the virtual environment
    source "$HOME/venv/bin/activate"
    _message "info" "Python virtual environment activated"
else
    _message "info" "Python virtual environment already exists"
fi

_message "success" "Preparation of ' ~/dotfiles-versions/$VERSION' successful"
