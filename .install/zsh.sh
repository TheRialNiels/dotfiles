#!/bin/bash

echo -e "${BLUE}"
    figlet "zsh"
echo -e "${NOCOLOR}"

# Change to SHELL to zsh
chsh -s /bin/zsh

# Install Zap, ZSH plugin manager
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
