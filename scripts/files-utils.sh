#!/usr/bin/env bash
# -----------------------------------------------------
# Files Utils
#
# This script contains functions to work with files.
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
# _replaceLineIfUnchanged - Replaces a line in a file if
# it is unchanged.
#
# Usage:
#   _replaceLineIfUnchanged <file> <oldLine> <newLine>
#
# Parameters:
#   file: The file to modify.
#   oldLine: The line to replace.
#   newLine: The new line to insert.
#
# Example:
#   _replaceLineIfUnchanged "file.txt" "old line" "new line"
# -----------------------------------------------------
_replaceLineIfUnchanged() {
    local file=$1
    local oldLine=$2
    local newLine=$3
    local runAsSudo=$4

    local rg_cmd="rg -Fxq"
    local sd_cmd="sd -s"

    # If the runAsSudo parameter is set to true, prepend sudo to the commands
    if [[ "$runAsSudo" == true ]]; then
        rg_cmd="sudo $rg_cmd"
        sd_cmd="sudo $sd_cmd"
    fi

    # Use ripgrep (rg) to check if the file contains the expected line (oldLine)
    if $rg_cmd "$oldLine" "$file"; then
        # If the line is present, replace it with the new line (newLine) using sd
        $sd_cmd "$oldLine" "$newLine" "$file"

        # Check if the line was successfully replaced
        # shellcheck disable=SC2181
        if [[ $? -eq 0 ]]; then
            msg="The line '$oldLine' was replaced with '$newLine' successfully in '$file'."
            _message "success" "$msg"
        else
            _message "error" "The line was not modified."
        fi
    elif $rg_cmd "$newLine" "$file"; then
        _message "info" "The line has already been modified."
    else
        _message "error" "The line was not found."
    fi
}
