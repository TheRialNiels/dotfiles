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
    "kitty"
    "zsh"
)

# Iterate over each configuration folder
for folder in "${configFolders[@]}"; do
    # Define the path of the folder
    case $mode in
    "dev")
        folderPath="$DOTFILES_SCRIPT_PATH/dotfiles/$folder"
        ;;
    "prod")
        folderPath="$HOME/dotfiles/$folder"
        ;;
    esac

    savedFolderPath="$HOME/dotfiles-versions/$VERSION/dotfiles/$folder"

    if [ -d "$savedFolderPath" ]; then
        case $folder in
        "gtk")
            # Create symlinks for GTK configuration files
            _createSymlink "$HOME/.config/gtk-3.0" "$folderPath/gtk3.0/" "$HOME/.config"
            _createSymlink "$HOME/.config/gtk-4.0" "$folderPath/gtk4.0/" "$HOME/.config"
            _createSymlink "$HOME/.config/xsettingsd" "$folderPath/xsettingsd/" "$HOME/.config"
            _createSymlink "$HOME/.gtkrc-2.0" "$folderPath/.gtkrc-2.0" "$HOME"
            _createSymlink "$HOME/.Xresources" "$folderPath/.Xresources" "$HOME"
            ;;
        "zsh")
            # Create symlinks for ZSH configuration files
            _createSymlink "$HOME/.zshenv" "$folderPath/.zshenv" "$HOME"
            _createSymlink "$HOME/.zshrc" "$folderPath/.zshrc" "$HOME"
            # Uncomment the following lines if needed to fix root symlinks
            # _createSymlink "/root/.zshenv" "$folderPath/.zshenv" "/root" "sudo"
            # _createSymlink "/root/.zshrc" "$folderPath/.zshrc" "/root" "sudo"
            ;;
        *)
            _createSymlink "$HOME/.config/$folder" "$folderPath/" "$HOME/.config"
            ;;
        esac
    fi
done
