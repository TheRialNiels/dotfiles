#!/usr/bin/env bash
# -----------------------------------------------------
# Set Keyboard Layout
#
# This script sets the keyboard layout.
# -----------------------------------------------------

echo -e "${BLUE}"
figlet "Keyboard"
echo -e "${NOCOLOR}"

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/general-utils.sh
source "$SCRIPTS_DIR/general-utils.sh"

# shellcheck source=../scripts/files-utils.sh
source "$SCRIPTS_DIR/files-utils.sh"

## Default layout and variants
keyboardLayout="us"

_confirmKeyboardLayout

configFile="$HOME/dotfiles-versions/$VERSION/dotfiles/hypr/config/keyboard.conf"
cp "$TMPL_PATH/keyboard.conf" "$configFile"

_replaceWordIfUnchanged "$configFile" "KEYBOARD_LAYOUT" "$keyboardLayout"

_message "success" "Keyboard layout set to '$keyboardLayout'"
_message "info" "You can update your keyboard layout later in '~/dotfiles/hypr/conf/keyboard.conf'"
