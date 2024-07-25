#!/usr/bin/env bash
# -----------------------------------------------------
# General Utils
#
# This script contains general functions that can be
# used in other scripts.
# -----------------------------------------------------

# -----------------------------------------------------
# _updateSystem - Updates the system using pacman.
# -----------------------------------------------------
_updateSystem() {
    # Update the package list
    sudo pacman -Syu --noconfirm
}

# -----------------------------------------------------
# _createSymlink - Creates a symbolic link.
#
# Usage:
#   _createSymlink <symlink> <linkSource> <linkTarget> [user]
#
# Parameters:
#   symlink     : The symlink to create.
#   linkSource  : The source of the symlink.
#   linkTarget  : The target of the symlink.
#   user        : The user to create the symlink.
#
# Example:
#   _createSymlink "$HOME/.config/gtk-2.0" "$HOME/dotfiles/gtk/gtk2.0/" "$HOME/.config"
# -----------------------------------------------------
_createSymlink() {
    symlink="$1"
    linkSource="$2"
    linkTarget="$3"
    user="$4"

    cmd_prefix=""
    [ "$user" = "sudo" ] && cmd_prefix="sudo"

    if [ -L "$symlink" ] || [ -d "$symlink" ] || [ -f "$symlink" ]; then
        $cmd_prefix rm -rf "$symlink"
    fi

    $cmd_prefix ln -s "$linkSource" "$linkTarget"

    # shellcheck disable=SC2181
    if [ $? -ne 0 ]; then
        _message "error" "Failed to create symlink '$linkSource' -> '$linkTarget'"
        exit 1 # Exit with error
    fi

    _message "success" "Symlink '$linkSource' -> '$linkTarget' created"
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

# -----------------------------------------------------
# _applyTheme - Applies a theme using wal.
#
# Usage:
#   _applyTheme <imgPath> <notiMsg>
#
# Parameters:
#   imgPath : The path to the image.
#   notiMsg : The notification message.
#
# Example:
#   _applyTheme "$HOME/Pictures/Wallpapers/wallpaper.jpg" "Applying theme..."
# -----------------------------------------------------
_applyTheme() {
    local imgPath="$1"
    local notiMsg="$2"

    notify-send "$notiMsg"
    wal -qnei "$imgPath"

    # Check if the theme was applied successfully
    # shellcheck disable=SC2181
    if [ $? -eq 0 ]; then
        notify-send "Color scheme applied successfully."
    else
        notify-send "Failed to apply color scheme."
    fi
}
