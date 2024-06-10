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
            _installSymLink "$HOME/.config/gtk-2.0" "$HOME/dotfiles/$folder/gtk/gtk2.0/" "$HOME/.config"
            _installSymLink "$HOME/.config/gtk-3.0" "$HOME/dotfiles/$folder/gtk/gtk3.0/" "$HOME/.config"
            _installSymLink "$HOME/.gtkrc-2.0" "$HOME/dotfiles/$folder/gtk/.gtkrc-2.0" "$HOME"
        fi
    elif [[ $folder == "zsh" ]]; then
        if [ -d "$HOME/dotfiles-versions/$VERSION/$folder" ]; then
            _installSymLink "$HOME/.zshenv" "$HOME/dotfiles/$folder/zsh/.zshenv" "$HOME/.zshenv"
            _installSymLink "$HOME/.zshrc" "$HOME/dotfiles/$folder/zsh/.zshrc" "$HOME/.zshrc"

            # TODO: Fix root symlinks
            #_installSymLink "/root/.zshrc" "$HOME/dotfiles/$folder/zsh/.zshenv" "/root/.zshenv" "sudo"
            #_installSymLink "/root/.zshrc" "$HOME/dotfiles/$folder/zsh/.zshrc" "/root/.zshrc" "sudo"
        fi
    elif [ -d "$HOME/dotfiles-versions/$VERSION/$folder" ]; then
        _installSymLink "$HOME/.config/$folder" "$HOME/dotfiles/$folder/" "$HOME/.config"
    fi
done
