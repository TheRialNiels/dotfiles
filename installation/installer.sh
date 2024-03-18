#!/bin/bash

# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "Packages"
echo -e "${NOCOLOR}"

if [ -d ~/dotfiles ] ;then
    echo -e "${CYAN}"
    echo "Do you want to check for new packages only (faster installation)"
    echo "or do you want to reinstall all packages again? (more robust and can help to fix issues)"

    echo -e "${BLUE}"
    if gum confirm "HOW DO YOU WANT TO PROCEED?" --default=false --affirmative "New packages only" --negative "Force reinstallation" ;then
        force_install=0
    elif [ $? -eq 130 ]; then
	echo -e "${NOCOLOR}"
        echo "Installation canceled."
        exit 130
    else
        force_install=1
    fi
else
    echo -e "${CYAN}"
    echo "Do you want to reinstall all already installed packages and install the required new packages? (recommended and more robust)"
    echo "or do you want to install the new required packages only? (could be faster installation)"
    
    echo -e "${BLUE}"
    if gum confirm "HOW DO YOU WANT TO PROCEED?" --default=false --affirmative "Reinstall all packages" --negative "Install new packages only" ;then
        force_install=1
    elif [ $? -eq 130 ]; then
	echo -e "${NOCOLOR}"
        echo "Installation canceled."
        exit 130
    else
        force_install=0
    fi
fi

echo -e "${NOCOLOR}"

