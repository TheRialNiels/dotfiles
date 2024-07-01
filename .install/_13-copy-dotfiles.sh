#!/usr/bin/env bash
# -----------------------------------------------------
# Copy Dotfiles
#
# This script copies the prepared dotfiles to the
# dotfiles directory.
# -----------------------------------------------------

## Print Title depending on the existence of DOTFILES
if [ ! -d "$DOTFILES" ]; then
    echo -e "${BLUE}"
    figlet "Installation"
    echo -e "${NOCOLOR}"
else
    echo -e "${BLUE}"
    figlet "Update"
    echo -e "${NOCOLOR}"
fi

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/folders-utils.sh
source "$SCRIPTS_DIR/folders-utils.sh"

## Display information messages based on the existence of DOTFILES
if [ ! -d "$DOTFILES" ]; then
    _message "important" "The script will now remove existing directories and files from '~/.config' and copy your prepared configuration from '~/dotfiles-versions/$VERSION/dotfiles' to '~/dotfiles'"
    _message "important" "Symbolic links will then be created from '~/dotfiles' into your '~/.config' directory"
else
    _message "important" "The script will overwrite existing files but will not remove additional files or folders from your custom configuration."
    _message "important" "PLEASE BACKUP YOUR EXISTING CONFIGURATIONS in '~/.config' IF NEEDED!"
fi

msg="DO YOU WANT TO INSTALL PREPARED DOTFILES NOW?"
if gum confirm "$msg"; then
    if [ ! $mode == "dev" ]; then
        # Create DOTFILES directory if it doesn't exist
        _createDirectoryIfNotExists "$DOTFILES"

        # Use rsync to copy dotfiles
        rsync -avhp -I "$HOME/dotfiles-versions/$VERSION/dotfiles/" "$DOTFILES/"

        # Check if rsync was unsuccessful
        if [[ $(_isFolderEmpty "$DOTFILES/") == 1 ]]; then
            _message "error" "Copying prepared dotfiles from '~/dotfiles-versions/$VERSION/dotfiles/' to '~/dotfiles/' failed"
            _message "error" "Please check that 'rsync' is installed on your system"
            exit 1 # Exit with error code
        fi

        # Show success message
        _message "success" "All files from '~/dotfiles-versions/$VERSION/dotfiles' to '~/dotfiles/' copied successfully"
    else
        _message "important" "Skipping copying of prepared dotfiles in 'dev' mode"
    fi
elif [ $? -eq 130 ]; then
    # User cancelled the installation
    _message "error" "Copying of prepared dotfiles cancelled!"
    exit 130 # Exit with cancel code
else
    # User declined the installation
    _message "error" "Copying of prepared dotfiles declined!"
    exit 1 # Exit with error code
fi
