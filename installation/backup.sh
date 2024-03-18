#!/bin/bash

# ------------------------------------------------------
# Backup existing dotfiles
# ------------------------------------------------------

datets=$(date '+%Y%m%d%H%M%S')
if [ -d ~/dotfiles ] || [ -f ~/.bashrc ] || [ -f ~/.zshrc ]; then
    echo -e "${BLUE}"
    figlet "Backup"

    echo -e "${CYAN}"
    if [ -d ~/dotfiles ]; then
        echo ":: The script has detected an existing dotfiles folder and will try to create a backup into the folder:"
        echo "   ~/dotfiles-versions/backups/$datets"
    fi

    if [ ! -L ~/.bashrc ] && [ -f ~/.bashrc ]; then
        echo ":: The script has detected an existing .bashrc file and will try to create a backup to:" 
        echo "   ~/dotfiles-versions/backups/$datets/.bashrc-old"
    fi

    if [ ! -L ~/.zshrc ] && [ -f ~/.zshrc ]; then
        echo ":: The script has detected an existing .zshrc file and will try to create a backup to:" 
        echo "   ~/dotfiles-versions/backups/$datets/.zshrc-old"
    fi

    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO CREATE A BACKUP?" --default=false;then
	echo -e "${CYAN}"

        if [ ! -d ~/dotfiles-versions ]; then
            mkdir ~/dotfiles-versions
            echo "~/dotfiles-versions created."
        fi
        if [ ! -d ~/dotfiles-versions/backups ]; then
            mkdir ~/dotfiles-versions/backups
            echo "~/dotfiles-versions/backups created"
        fi
        if [ ! -d ~/dotfiles-versions/backups/$datets ]; then
            mkdir ~/dotfiles-versions/backups/$datets
            echo "~/dotfiles-versions/backups/$datets created"
        fi
        if [ -d ~/dotfiles ]; then
            rsync -a ~/dotfiles/ ~/dotfiles-versions/backups/$datets/
            echo ":: Backup of your current dotfiles in ~/dotfiles-versions/backups/$datets created."
        fi
        if [ -f ~/.bashrc ]; then
            cp ~/.bashrc ~/dotfiles-versions/backups/$datets/.bashrc-old
            echo ":: Existing .bashrc file found in homefolder. .bashrc-old created"
        fi
        if [ -f ~/.zshrc ]; then
            cp ~/.zshrc ~/dotfiles-versions/backups/$datets/.zshrc-old
            echo ":: Existing .zshrc file found in homefolder. .zshrc-old created"
        fi

        echo -e "\n"
        echo ":: PLEASE NOTE: You can create a fresh installation of the dotfiles by removing the folder ~/dotfiles"
	echo -e "${NOCOLOR}"
    elif [ $? -eq 130 ]; then
        exit 130
    else
        echo ":: Backup skipped."
    fi
    echo ""
fi

echo -e "${NOCOLOR}"

