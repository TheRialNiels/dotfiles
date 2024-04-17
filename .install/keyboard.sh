#!/usr/bin/env bash

# ------------------------------------------------------
# Setup
# ------------------------------------------------------
echo -e "${BLUE}"
figlet "Keyboard"
echo -e "${NOCOLOR}"

# Default layout and variants
keyboard_layout="us"

_setupKeyboardLayout() {
    echo -e "Start typing = Search, RETURN = Confirm, CTRL-C = Cancel\n"
    keyboard_layout=$(localectl list-x11-keymap-layouts | gum filter --height 15 --placeholder "Find your keyboard layout...")

    _showSuccessMsg "Keyboard layout changed to $(_changeTextWhite "$keyboard_layout")"
    _confirmKeyboard
}

_confirmKeyboard() {
    _showNormalMsg "Current keyboard layout: $keyboard_layout"

    echo -e "${BLUE}"
    if gum confirm "DO YOU WANT TO PROCEED WHITH THIS KEYBOARD SETUP?" --affirmative "Proceed" --negative "Change" --default=false; then
        return 0
    elif [ $? -eq 130 ]; then
        exit 130
    else
        echo -e "${NOCOLOR}"
        _setupKeyboardLayout
    fi
}

_confirmKeyboard

cp "$TMPL_PATH/keyboard.conf" "$HOME/dotfiles-versions/$VERSION/hypr/conf/keyboard.conf"

SEARCH="KEYBOARD_LAYOUT"
REPLACE="$keyboard_layout"
sed -i "s/$SEARCH/$REPLACE/g" "$HOME/dotfiles-versions/$VERSION/hypr/conf/keyboard.conf"

_showSuccessMsg "Keyboard setup updated successfully"
_showInfoMsg "You can update your keyboard layout later in $(_changeTextWhite " ~/dotfiles/hypr/conf/keyboard.conf")"
