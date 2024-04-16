#!/bin/bash

# ------------------------------------------------------
# Backup existing dotfiles
# ------------------------------------------------------

date_timestamp=$(date '+%Y%m%d%H%M%S')
if [ -d "$DOTFILES" ]; then
    echo -e "${BLUE}"
    figlet "Backup"
    echo -e "${NOCOLOR}"

    _showInfoMsg "The script has detected an existing dotfiles folder and will try to create a backup into the folder:"
    echo -e "\t$(_changeTextColor "$WHITE" "$HOME/dotfiles-versions/backups/$date_timestamp")"

    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO CREATE A BACKUP?" --default=false; then
        echo -e "${CYAN}"

        if [ ! -d "$HOME/dotfiles-versions" ]; then
            mkdir "$HOME/dotfiles-versions"
            _showInfoMsg "$(_changeTextColor "$WHITE" "$HOME/dotfiles-versions") created"
        fi
        if [ ! -d "$HOME/dotfiles-versions/backups" ]; then
            mkdir "$HOME/dotfiles-versions/backups"
            _showInfoMsg "$(_changeTextColor "$WHITE" "$HOME/dotfiles-versions/backups") created"
        fi
        if [ ! -d "$HOME/dotfiles-versions/backups/$date_timestamp" ]; then
            mkdir "$HOME/dotfiles-versions/backups/$date_timestamp"
            _showInfoMsg "$(_changeTextColor "$WHITE" "$HOME/dotfiles-versions/backups/$date_timestamp") created"
        fi
        if [ -d "$DOTFILES" ]; then
            rsync -a "$DOTFILES" "$HOME/dotfiles-versions/backups/$date_timestamp/"
            _showInfoMsg "Backup of your current dotfiles in $(_changeTextColor "$WHITE" "$HOME/dotfiles-versions/backups/$date_timestamp") created"
        fi

        _showImportantMsg "You can create a fresh installation of the dotfiles by removing the folder $(_changeTextColor "$WHITE" "$HOME/dotfiles")"
    elif [ $? -eq 130 ]; then
        exit 130
    else
        _showInfoMsg "Backup skipped"
    fi
fi

echo -e "${NOCOLOR}"
