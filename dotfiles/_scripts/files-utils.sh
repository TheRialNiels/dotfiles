#!/usr/bin/env bash
# -----------------------------------------------------
# Files Utils
#
# This script contains functions to work with files.
# -----------------------------------------------------

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

# -----------------------------------------------------
# _replaceWordIfUnchanged - Replaces a word in a file if
# it is unchanged.
#
# Usage:
#   _replaceWordIfUnchanged <file> <oldWord> <newWord>
#
# Parameters:
#   file: The file to modify.
#   oldWord: The word to replace.
#   newWord: The new word to insert.
#
# Example:
#   _replaceWordIfUnchanged "file.txt" "old" "new"
#   _replaceWordIfUnchanged "file.txt" "old" "new" true
# -----------------------------------------------------
_replaceWordIfUnchanged() {
    local file=$1
    local oldWord=$2
    local newWord=$3
    local runAsSudo=$4

    local sd_cmd="sd -s"

    # If the runAsSudo parameter is set to true, prepend sudo to the commands
    if [[ "$runAsSudo" == true ]]; then
        rg_cmd="sudo $rg_cmd"
        sd_cmd="sudo $sd_cmd"
    fi

    # If the line is present, replace it with the new line (newLine) using sd
    $sd_cmd "$oldWord" "$newWord" "$file"

    # Check if the line was successfully replaced
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        msg="The word '$oldWord' was replaced with '$newWord' successfully in '$file'."
        _message "success" "$msg"
    else
        _message "error" "The word was not modified."
    fi
}

# -----------------------------------------------------
# _replaceLineInTemplate - Replaces a line in a template
# file if it is unchanged.
#
# Usage:
#   _replaceLineInTemplate <templatePath> <cachePath> <fileName> <oldLine> <newLine>
#
# Parameters:
#   templatePath: The path to the template file.
#   cachePath: The path to the cache file.
#   fileName: The name of the file.
#   oldLine: The line to replace.
#   newLine: The new line to insert.
#
# Example:
#   _replaceLineInTemplate "$HOME/.config" "$HOME/.cache" "file.txt" "old line" "new line"
# -----------------------------------------------------
_replaceLineInTemplate() {
    local templatePath="$1"
    local cachePath="$2"
    local fileName="$3"
    local oldLine="$4"
    local newLine="$5"

    if [[ -z "$templatePath" || -z "$cachePath" || -z "$fileName" || -z "$oldLine" || -z "$newLine" ]]; then
        echo "Usage: replace_line_in_template <templatePath> <cachePath> <fileName> <oldLine> <newLine> [runAsSudo]"
        return 1
    fi

    local templateFile="${templatePath}/${fileName}"
    local cacheFile="${cachePath}/${fileName}"

    if [[ ! -f "$templateFile" ]]; then
        _message "error" "Template file '${templateFile}' does not exist."
        return 1 # Return error
    fi

    if [[ ! -f "$cacheFile" ]]; then
        _message "error" "Cache file '${cacheFile}' does not exist."
        return 1 # Return error
    fi

    _replaceLineIfUnchanged "$cacheFile" "$oldLine" "$newLine"
}

# -----------------------------------------------------
# _createCacheFile - Creates a cache file if it does not
# exist.
#
# Usage:
#   _createCacheFile <filePath> <content>
#
# Parameters:
#   filePath: The path to the file to create.
#   content: The content to write to the file.
#
# Example:
#   _createCacheFile "$HOME/.cache/file" "Hello, World!"
# -----------------------------------------------------
_createCacheFile() {
    local filePath=$1
    local content=$2

    if [ ! -f "$filePath" ]; then
        echo "$content" >"$filePath"

        # Check if the file was successfully created
        if [ -f "$filePath" ]; then
            _message "success" "'$(basename "$filePath")' created"
        else
            _message "error" "Failed to create '$(basename "$filePath")'"
        fi
    fi
}

# -----------------------------------------------------
# _updateWallpaperCacheFiles - Updates the wallpaper
# cache files.
#
# Usage:
#   _updateWallpaperCacheFiles <pathWall>
#
# Parameters:
#   pathWall: The path to the wallpaper.
#
# Example:
#   _updateWallpaperCacheFiles "$HOME/Pictures/Wallpapers/wallpaper.jpg"
# -----------------------------------------------------
_updateWallpaperCacheFiles() {
    local cache_wall="$HOME/.cache/wallpaper/current_wallpaper"
    local cache_wall_rasi="$HOME/.cache/wallpaper/current_wallpaper.rasi"
    local path_wall=$1

    echo "$path_wall" >"$cache_wall"
    echo "* { current-image: url(\"$path_wall\", height); }" >"$cache_wall_rasi"

    # Check if the file was updated successfully
    if [ -f "$cache_wall" ]; then
        _message "success" "'$(basename "$cache_wall")' updated"
    else
        _message "error" "Failed to update '$(basename "$cache_wall")'"
    fi
}
