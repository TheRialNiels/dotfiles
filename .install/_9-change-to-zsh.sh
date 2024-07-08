#!/usr/bin/env bash
# -----------------------------------------------------
# Change to Zsh
#
# This script changes the default shell to Zsh.
# -----------------------------------------------------

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

## Check if Zap Command is installed
if [[ ! -d "$HOME/.local/share/zap" ]]; then
    ## Install Zap, ZSH plugin manager to current user
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 && echo -e "\n"

    ## Create a symlink for the root user
    _message "info" "Creating a symlink of 'Zap (ZSH plugin manager)' for the root user..."
    _message "normal" "Insert the password to access to root user in order to create symlink for 'Zap (ZSH plugin manager)'"

    su -c "ln -s /home/$(whoami)/.zap /root/.zap && echo -e '\n'"

    ## Check if the symlink was created
    if [[ -L /root/.zap ]]; then
        _message "success" "Symlink created for 'Zap (ZSH plugin manager)'."
    else
        _message "error" "Symlink could not be created for 'Zap (ZSH plugin manager)'."
    fi
else
    _message "info" "'Zap (ZSH plugin manager)' is already installed."
fi
