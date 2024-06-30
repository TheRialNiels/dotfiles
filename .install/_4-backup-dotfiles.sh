#!/usr/bin/env bash
# -----------------------------------------------------
# Backup Dotfiles
#
# This script creates a backup of the current dotfiles
# folder.
# -----------------------------------------------------

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/folders-utils.sh
source "$SCRIPTS_DIR/folders-utils.sh"

dateTimestamp=$(date '+%Y%m%d%H%M%S')
backupDir="$HOME/dotfiles-versions/backups/$dateTimestamp"

## Check if dotfiles folder exists
if [ -d "$DOTFILES" ]; then
    echo -e "${BLUE}"
    figlet "Backup"
    echo -e "${NOCOLOR}"

    _message "info" "The script has detected an existing dotfiles folder and will try to create a backup into the folder: '$backupDir'"

    msg="DO YOU WANT TO CREATE A BACKUP?"
    if gum confirm "$msg" --default=false; then
        _createDirectoryIfNotExists "$HOME/dotfiles-versions"
        _createDirectoryIfNotExists "$HOME/dotfiles-versions/backups"
        _createDirectoryIfNotExists "$backupDir"

        # Check if dotfiles folder exists and create a backup
        if [ -d "$DOTFILES" ]; then
            rsync -a "$DOTFILES" "$backupDir/"
            _message "success" "Backup of your current dotfiles in '$backupDir' created"
        fi

        _message "important" "You can create a fresh installation of the dotfiles by removing the folder '~/dotfiles' and running the installation script again"
    elif [ $? -eq 130 ]; then
        _message "error" "Backup canceled!"
        exit 130 # Exit with cancel code
    else
        _message "warn" "Backup declined!"
    fi
fi
