#!/bin/bash

echo -e "${BLUE}"
figlet "zsh"
echo -e "${NOCOLOR}"

# Change to SHELL to zsh to current user
chsh -s /bin/zsh && echo -e "\n"

# Change to SHELL to zsh to root user
sudo chsh -s /bin/zsh && echo -e "\n"

# Install Zap, ZSH plugin manager to current user
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 && echo -e "\n"

# Install Zap, ZSH plugin manager to root user
_showNormalMsg "Now insert the password to access to root user in order to install Zap (ZSH plugin manager)"

su -c "zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 && echo -e '\n'"
