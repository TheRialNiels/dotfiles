#!/usr/bin/env bash

# ------------------------------------------------------
# Backup existing dotfiles
# ------------------------------------------------------

date_timestamp=$(date '+%Y%m%d%H%M%S')
if [ -d "$DOTFILES" ]; then
    echo -e "${BLUE}"
    figlet "Backup"
    echo -e "${NOCOLOR}"

    _showNormalMsg "The script has detected an existing dotfiles folder and will try to create a backup into the folder:"
    echo -e "\t$(_changeTextWhite " ~/dotfiles-versions/backups/$date_timestamp")"

    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO CREATE A BACKUP?" --default=false; then
        echo -e "${CYAN}"

        if [ ! -d "$HOME/dotfiles-versions" ]; then
            mkdir "$HOME/dotfiles-versions"
            _showSuccessMsg "$(_changeTextWhite " ~/dotfiles-versions") created"
        fi
        if [ ! -d "$HOME/dotfiles-versions/backups" ]; then
            mkdir "$HOME/dotfiles-versions/backups"
            _showSuccessMsg "$(_changeTextWhite " ~/dotfiles-versions/backups") created"
        fi
        if [ ! -d "$HOME/dotfiles-versions/backups/$date_timestamp" ]; then
            mkdir "$HOME/dotfiles-versions/backups/$date_timestamp"
            _showSuccessMsg "$(_changeTextWhite " ~/dotfiles-versions/backups/$date_timestamp") created"
        fi
        if [ -d "$DOTFILES" ]; then
            rsync -a "$DOTFILES" "$HOME/dotfiles-versions/backups/$date_timestamp/"
            _showSuccessMsg "Backup of your current dotfiles in $(_changeTextWhite " ~/dotfiles-versions/backups/$date_timestamp") created"
        fi

        _showImportantMsg "You can create a fresh installation of the dotfiles by removing the folder $(_changeTextWhite " ~/dotfiles")"
    elif [ $? -eq 130 ]; then
        exit 130
    else
        _showNormalMsg "Backup skipped"
    fi
fi
