#!/usr/bin/env bash
# -----------------------------------------------------
# Print Title
#
# This script prints the title of the dotfiles.
# -----------------------------------------------------

## Source Utils
# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

clear

echo -e "${BLUE}"
figlet -f slant -t -c "HYPRLAND DOTFILES"

echo -e "${WHITE}"
figlet -f small -t -c "VERSION " "$VERSION"

figlet -f small -t -c "BY  THE  RIAL  NIELS"
echo -e "${NOCOLOR}"

if [[ "$mode" == "dev" ]]; then
    echo -e "${ORANGE}"
    figlet -f small -t -c "Dev Mode"
    echo -e "${NOCOLOR}"

    _message "important" "Running in 'development mode'"
fi
