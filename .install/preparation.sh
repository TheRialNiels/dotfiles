#!/usr/bin/env bash

# ------------------------------------------------------
# Prepare dotfiles
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "Preparation"
echo -e "${NOCOLOR}"

if [ -d "$HOME/.config" ]; then
    _showInfoMsg "$(_changeTextWhite ".config/") folder already exists"
else
    mkdir "$HOME/.config"
    _showSuccessMsg "$(_changeTextWhite ".config/") folder created"
fi

_showNormalMsg "Preparing temporary folders for the installation"

if [ ! -d "$HOME/dotfiles-versions" ]; then
    mkdir "$HOME/dotfiles-versions"
    _showSuccessMsg "$(_changeTextWhite " ~/dotfiles-versions") folder created"
fi

if [ ! -d "$HOME/dotfiles-versions/$VERSION" ]; then
    mkdir "$HOME/dotfiles-versions/$VERSION"
    _showSuccessMsg "$(_changeTextWhite " ~/dotfiles-versions/$VERSION") folder created"
else
    _showInfoMsg "The folder $(_changeTextWhite " ~/dotfiles-versions/$VERSION") already exists from previous installations"
    rm -rf "$HOME/dotfiles-versions/$VERSION"
    mkdir "$HOME/dotfiles-versions/$VERSION"
    _showNormalMsg "Clean build prepared for the installation"
fi

rsync -a -I --exclude-from="$INST_PATH/includes/excludes.txt" . "$HOME/dotfiles-versions/$VERSION/"

if [[ $(_isFolderEmpty "$HOME/dotfiles-versions/$VERSION/") == 0 ]]; then
    _showErrorMsg "Preparation of $(_changeTextWhite " ~/dotfiles-versions/$VERSION") failed"
    _showImportantMsg "Please check that rsync is installed on your system"
    _showImportantMsg "Execution of $(_changeTextWhite "rsync -a -I --exclude-from='$INST_PATH/includes/excludes.txt' . ~/dotfiles-versions/$VERSION") is required"

    exit
fi

_showSuccessMsg "dotfiles $VERSION successfully prepared in $(_changeTextWhite " ~/dotfiles-versions/$VERSION/")"
