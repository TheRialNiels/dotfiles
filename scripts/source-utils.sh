#!/usr/bin/env bash

## Source Utils

# shellcheck source=./colors.sh
source "$SCRIPTS_DIR/colors.sh"

# shellcheck source=../dotfiles/_scripts/messages-utils.sh
source "$DOTFILES_SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../dotfiles/_scripts/general-utils.sh
source "$DOTFILES_SCRIPTS_DIR/general-utils.sh"

# shellcheck source=../dotfiles/_scripts/packages-utils.sh
source "$DOTFILES_SCRIPTS_DIR/packages-utils.sh"

# shellcheck source=../dotfiles/_scripts/folders-utils.sh
source "$DOTFILES_SCRIPTS_DIR/folders-utils.sh"

# shellcheck source=../dotfiles/_scripts/files-utils.sh
source "$DOTFILES_SCRIPTS_DIR/files-utils.sh"
