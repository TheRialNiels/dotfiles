#!/usr/bin/env bash
# -----------------------------------------------------
# Folders Utils
#
# This script contains functions to work with folders.
#
# Made by TheRialNiels
# -----------------------------------------------------

# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# -----------------------------------------------------
# _createDirectoryIfNotExists - Creates a directory if it
# does not exist.
#
# Usage:
#   _createDirectoryIfNotExists <dir>
#
# Parameters:
#   dir: The directory to create.
#
# Example:
#   _createDirectoryIfNotExists "$HOME/dotfiles-versions"
# -----------------------------------------------------
_createDirectoryIfNotExists() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        _message "success" "The directory '$dir' was created successfully."
    fi
}

# -----------------------------------------------------
# _isFolderEmpty - Checks if a folder is empty.
#
# Usage:
#   _isFolderEmpty <folder>
#
# Parameters:
#   folder: The folder to check.
#
# Example:
#   _isFolderEmpty "$HOME/dotfiles-versions/$VERSION/"
# -----------------------------------------------------
_isFolderEmpty() {
    if [ -z "$(ls -A "$1")" ]; then
        echo 1
    else
        echo 0
    fi
}
