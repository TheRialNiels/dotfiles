#!/usr/bin/env bash

## Define Variables
SCRIPTS_DIR="$DOTFILES/_scripts"
WAYBAR_DIR="$DOTFILES/waybar"

## Source Scripts
# shellcheck source=../_scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../_scripts/general-utils.sh
source "$SCRIPTS_DIR/general-utils.sh"

# shellcheck source=../_scripts/folders-utils.sh
source "$SCRIPTS_DIR/folders-utils.sh"

# shellcheck source=../_scripts/files-utils.sh
source "$SCRIPTS_DIR/files-utils.sh"

_applyWaybarTheme() {
    local primaryColor="$1"
    local secondaryColor="$2"

    _replaceHexColor "$WAYBAR_DIR/modules/group/clock/clock.jsonc" "15" "$secondaryColor"
    _replaceHexColor "$WAYBAR_DIR/modules/group/clock/clock.jsonc" "16" "$primaryColor"
    _replaceHexColor "$WAYBAR_DIR/modules/group/clock/clock.jsonc" "17" "$secondaryColor"
    _replaceHexColor "$WAYBAR_DIR/modules/group/clock/clock.jsonc" "18" "$secondaryColor"

    ## Reload the waybar
    $DOTFILES/waybar/launch.sh
}
