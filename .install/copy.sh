#!/usr/bin/env bash

# ------------------------------------------------------
# Copy dotfiles
# ------------------------------------------------------
if [ ! -d "$DOTFILES" ]; then
    echo -e "${BLUE}"
    figlet "Installation"
    echo -e "${NOCOLOR}"
else
    echo -e "${BLUE}"
    figlet "Update"
    echo -e "${NOCOLOR}"
fi

if [ ! -d "$DOTFILES" ]; then
    _showInfoMsg "The script will now remove existing directories and files from $(_changeTextWhite " ~/.config/")\
    \nand copy your prepared configuration from $(_changeTextWhite " ~/dotfiles-versions/$VERSION") to $(_changeTextWhite " ~/dotfiles")"

    _showInfoMsg "Symbolic links will then be created from $(_changeTextWhite " ~/dotfiles") into your $(_changeTextWhite " ~/.config/") directory."
fi

if [ -d "$DOTFILES" ]; then
    _showNormalMsg "The script will overwrite existing files but will not remove additional files or folders from your custom configuration."
fi

if [ ! -d "$DOTFILES" ]; then
    _showInfoMsg "PLEASE BACKUP YOUR EXISTING CONFIGURATIONS in $(_changeTextWhite " .config") IF NEEDED!"
fi

echo -e "${BLUE}"
if gum confirm "DO YOU WANT TO INSTALL PREPARED DOTFILES NOW?"; then
    if [ ! -d "$DOTFILES" ]; then
        mkdir "$HOME/dotfiles"
        _showSuccessMsg "$(_changeTextWhite " ~/dotfiles") folder created"
    fi

    rsync -avhp -I "$HOME/dotfiles-versions/$VERSION/" "$DOTFILES/"

    if [[ $(_isFolderEmpty ~/dotfiles/) == 0 ]]; then
        _showErrorMsg "Copy prepared dofiles from $(_changeTextWhite " ~/dotfiles-versions/$VERSION/") to $(_changeTextWhite " ~/dotfiles/") failed"
        _showImportantMsg "Please check that rsync is installed on your system"
        _showImportantMsg "Execution of $(_changeTextWhite "rsync -a -I ~/dotfiles-versions/$VERSION/ ~/dotfiles/") is required"
        exit
    fi

    _showSuccessMsg "All files from $(_changeTextWhite " ~/dotfiles-versions/$VERSION/") to $(_changeTextWhite " ~/dotfiles/") copied"
elif [ $? -eq 130 ]; then
    exit 130
else
    exit
fi

echo -e "${NOCOLOR}"
