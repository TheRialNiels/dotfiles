#!/usr/bin/env bash
# -----------------------------------------------------
# Change to Zsh
#
# This script changes the default shell to Zsh.
#
# Made by TheRialNiels
# -----------------------------------------------------

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/packages-utils.sh
source "$SCRIPTS_DIR/packages-utils.sh"

## Print Change to Zsh Title
echo -e "${BLUE}"
figlet "zsh"
echo -e "${NOCOLOR}"

## Check if Zsh is installed
if [[ $(_checkIsInstalledWith "pacman" "zsh") == 1 ]]; then
    _message "error" "'zsh' is not installed. Please install 'zsh' before running this script."
    exit 1
fi

## Check if Zsh is the default shell for the user
if [[ "$SHELL" == "/bin/zsh" ]]; then
    _message "info" "'zsh' is already the default shell."
else
    # Change the shell for the current user
    _message "info" "Changing the default shell to 'zsh'..."
    chsh -s /bin/zsh
    _message "success" "Default shell changed to 'zsh'."

    # Change the shell for the root user
    _message "info" "Changing the default shell for the root user to 'zsh'..."
    sudo chsh -s /bin/zsh
    _message "success" "Default shell for the root user changed to 'zsh'."
fi
