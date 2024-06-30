#!/usr/bin/env bash
# -----------------------------------------------------
# Create Symlinks
#
# This script creates the symlinks for the dotfiles.
# -----------------------------------------------------

echo -e "${BLUE}"
figlet "Symlinks"
echo -e "${NOCOLOR}"

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/general-utils.sh
source "$SCRIPTS_DIR/general-utils.sh"

# List of configuration folders
configFolders=(
    "hypr"
)

# Iterate over each configuration folder
for folder in "${configFolders[@]}"; do
    folder_path="$HOME/dotfiles-versions/$VERSION/dotfiles/$folder"
    
    if [ -d "$folder_path" ]; then
        case $folder in
            "gtk")
                _createSymlink "$HOME/.config/gtk-2.0" "$HOME/dotfiles/$folder/gtk/gtk2.0/" "$HOME/.config"
                _createSymlink "$HOME/.config/gtk-3.0" "$HOME/dotfiles/$folder/gtk/gtk3.0/" "$HOME/.config"
                _createSymlink "$HOME/.gtkrc-2.0" "$HOME/dotfiles/$folder/gtk/.gtkrc-2.0" "$HOME"
                ;;
            "zsh")
                _createSymlink "$HOME/.zshenv" "$HOME/dotfiles/$folder/zsh/.zshenv" "$HOME"
                _createSymlink "$HOME/.zshrc" "$HOME/dotfiles/$folder/zsh/.zshrc" "$HOME"
                # Uncomment the following lines if needed to fix root symlinks
                # _createSymlink "/root/.zshenv" "$HOME/dotfiles/$folder/zsh/.zshenv" "/root" "sudo"
                # _createSymlink "/root/.zshrc" "$HOME/dotfiles/$folder/zsh/.zshrc" "/root" "sudo"
                ;;
            *)
                _createSymlink "$HOME/.config/$folder" "$HOME/dotfiles/$folder/" "$HOME/.config"
                ;;
        esac
    fi
done
