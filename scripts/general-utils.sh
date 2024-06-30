#!/usr/bin/env bash
# -----------------------------------------------------
# General Utils
#
# This script contains general functions that can be
# used in other scripts.
# -----------------------------------------------------

# shellcheck source=./messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# -----------------------------------------------------
# _updateSystem - Updates the system using pacman.
# -----------------------------------------------------
_updateSystem() {
    # Update the package list
    sudo pacman -Syu --noconfirm
}

# -----------------------------------------------------
# _confirmKeyboardLayout - Confirms the keyboard layout.
# -----------------------------------------------------
_confirmKeyboardLayout() {
    _message "normal" "Current keyboard layout: '$keyboardLayout'"

    msg="DO YOU WANT TO PROCEED WITH THIS KEYBOARD SETUP?"
    if gum confirm "$msg" --affirmative "Proceed" --negative "Change"; then
        return 0
    elif [ $? -eq 130 ]; then
        _message "error" "Keyboard layout not set"
        exit 130
    else
        _setupKeyboardLayout
    fi
}

# -----------------------------------------------------
# _setupKeyboardLayout - Prompts the user to
# select a keyboard layout.
# -----------------------------------------------------
_setupKeyboardLayout() {
    echo -e "Start typing = Search, RETURN = Confirm, CTRL-C = Cancel\n"
    msg="Find your keyboard layout..."
    keyboardLayout=$(localectl list-x11-keymap-layouts | rg '' | gum filter --height 15 --placeholder "$msg")

    if [ $? -eq 130 ]; then
        _message "error" "Keyboard layout not set"
        exit 130
    fi

    _message "success" "Keyboard layout changed to '$keyboardLayout'"
    _confirmKeyboardLayout
}

# -----------------------------------------------------
# _enableServices - Enables services using systemctl.
#
# Usage:
#   _enableServices <service1> <service2> ...
# -----------------------------------------------------
_enableServices() {
    for service in "$@"; do
        if systemctl is-active --quiet "$service"; then
            _message "info" "'$service' is already running"
        else
            sudo systemctl enable --now "$service"

            # shellcheck disable=SC2181
            if [ $? -ne 0 ]; then
                _message "error" "Failed to activate '$service'"
            else
                _message "success" "'$service' activated successfully."
            fi
        fi
    done
}
