#!/bin/bash

# ------------------------------------------------------
# Setup
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "Keyboard"
echo -e "${NOCOLOR}"

# Default layout and variants
keyboard_layout="us"

_setupKeyboardLayout() {
    echo ""
    echo "Start typing = Search, RETURN = Confirm, CTRL-C = Cancel"
    keyboard_layout=$(localectl list-x11-keymap-layouts | gum filter --height 15 --placeholder "Find your keyboard layout...")
    echo ""
    echo ":: Keyboard layout changed to $keyboard_layout"
    echo ""
    _confirmKeyboard
}

_confirmKeyboard() {
    echo -e "${NOCOLOR}"
    echo "Current selected keyboard setup:"
    echo "Keyboard layout: $keyboard_layout"

    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO PROCEED WHITH THIS KEYBOARD SETUP?" --affirmative "Proceed" --negative "Change" --default=false;then
        return 0
    elif [ $? -eq 130 ]; then
        exit 130
    else
	echo -e "${NOCOLOR}"
        _setupKeyboardLayout
    fi
}

if [ "$restored" == "1" ]; then
    echo -e "${CYAN}"
    echo ":: You have already restored your settings into the new installation."
else
    _confirmKeyboard
    
    cp ${tpl_path}keyboard.conf ~/dotfiles-versions/$version/hypr/conf/keyboard.conf

    SEARCH="KEYBOARD_LAYOUT"
    REPLACE="$keyboard_layout"
    sed -i "s/$SEARCH/$REPLACE/g" ~/dotfiles-versions/$version/hypr/conf/keyboard.conf

    echo -e "\n"
    echo -e "${CYAN}"
    echo ":: Keyboard setup updated successfully."
    echo "PLEASE NOTE: You can update your keyboard layout later in ~/dotfiles/hypr/conf/keyboard.conf"
fi

echo -e "${NOCOLOR}"

