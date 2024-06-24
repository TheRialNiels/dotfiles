#!/usr/bin/env bash
# -----------------------------------------------------
# Source Utils
#
# This script sources all the required files for the
# dotfiles to work properly.
#
# Made by TheRialNiels
# -----------------------------------------------------

# shellcheck source=../scripts/colors.sh
source "$SCRIPTS_DIR/colors.sh"

# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../scripts/general-utils.sh
source "$SCRIPTS_DIR/general-utils.sh"

# shellcheck source=../scripts/packages-utils.sh
source "$SCRIPTS_DIR/packages-utils.sh"

# shellcheck source=../scripts/files-utils.sh
source "$SCRIPTS_DIR/files-utils.sh"

# shellcheck source=../scripts/folders-utils.sh
source "$SCRIPTS_DIR/folders-utils.sh"
