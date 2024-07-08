#!/usr/bin/env bash
# -----------------------------------------------------
# Folders Utils
#
# This script contains functions to work with folders.
# -----------------------------------------------------

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
    else
        _message "info" "The directory '$dir' already exists."
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
# Returns:
#   0 if the folder is not empty.
#   1 if the folder is empty.
#
# Example:
#   _isFolderEmpty "$HOME/dotfiles-versions/$VERSION/"
# -----------------------------------------------------
_isFolderEmpty() {
    if [ -z "$(ls -A "$1")" ]; then
        echo 1 # Folder is empty
    else
        echo 0 # Folder is not empty
    fi
}

# -----------------------------------------------------
# _checkWallpapers - Checks if the wallpapers directory
# exists and if it is empty.
#
# Usage:
#   _checkWallpapers <path>
#
# Parameters:
#   path: The path to the wallpapers directory.
#
# Example:
#   _checkWallpapers "$HOME/Pictures/Wallpapers"
# -----------------------------------------------------
_checkWallpapers() {
    local path="$1"

    if [[ -d "$path" ]]; then
        # Check if the directory is empty
        if [[ $(_isFolderEmpty "$path") == 1 ]]; then
            notify-send "There are no wallpapers in: $path"
            exit 1 # Return error
        fi
    else
        # Create the directory and notify the user to add wallpapers
        mkdir -p "$path"
        notify-send "Put some wallpapers in: $path"
        exit 1 # Return error
    fi
}
