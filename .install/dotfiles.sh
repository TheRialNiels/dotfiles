#!/usr/bin/env bash

# ------------------------------------------------------
# Install dotfiles
# ------------------------------------------------------
config_folders=(
    "dunst"
    "fuzzel"
    "gtk"
    "hypr"
    "kitty"
    "neofetch"
    "nwg-look"
    "pacseek"
    "starship"
    "swappy"
    "waybar"
    "wlogout"
    "wofi"
    "xsettingsd"
    "yazi"
    "zsh"
)

for index in "${!config_folders[@]}"; do
    folder="${config_folders[$index]}"

    if [[ $folder == "gtk" ]]; then
        if [ -d "$HOME/dotfiles-versions/$VERSION/$folder" ]; then
            _installSymLink "$HOME/.config/gtk-2.0" "$HOME/dotfiles/$folder/gtk2.0/" "$HOME/.config"
            _installSymLink "$HOME/.config/gtk-3.0" "$HOME/dotfiles/$folder/gtk3.0/" "$HOME/.config"
            _installSymLink "$HOME/.gtkrc-2.0" "$HOME/dotfiles/$folder/.gtkrc-2.0" "$HOME"
        fi
    elif [[ $folder == "zsh" ]]; then
        if [ -d "$HOME/dotfiles-versions/$VERSION/$folder" ]; then
            _installSymLink "$HOME/.config/.zshenv" "$HOME/dotfiles/$folder/.zshenv" "$HOME/.config"
            _installSymLink "$HOME/.config/.zshrc" "$HOME/dotfiles/$folder/.zshrc" "$HOME/.config"
        fi
    elif [ -d "$HOME/dotfiles-versions/$VERSION/$folder" ]; then
        _installSymLink "$HOME/.config/$folder" "$HOME/dotfiles/$folder/" "$HOME/.config"
    fi
done
