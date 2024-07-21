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

_replaceColorsInTemplates() {
    local PATH_TMPL="$1"
    local PATH_PYWAL="$2"
    local background="$3"
    local altBackground="$4"
    local altBackground2="$5"
    local foreground="$6"
    local altForeground="$7"
    local altForeground2="$8"

    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.sh" "foregroundAlt='$foreground'" "foregroundAlt='$altForeground'"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.sh" "foregroundAlt2='$foreground'" "foregroundAlt2='$altForeground2'"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.sh" "backgroundAlt='$background'" "backgroundAlt='$altBackground'"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.sh" "backgroundAlt2='$background'" "backgroundAlt2='$altBackground2'"

    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.css" "@define-color foregroundAlt $foreground;" "@define-color foregroundAlt $altForeground;"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.css" "@define-color foregroundAlt2 $foreground;" "@define-color foregroundAlt2 $altForeground2;"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.css" "@define-color backgroundAlt $background;" "@define-color backgroundAlt $altBackground;"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.css" "@define-color backgroundAlt2 $background;" "@define-color backgroundAlt2 $altBackground2;"

    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.conf" "\$foregroundAlt = rgb(${foreground:1:6})" "\$foregroundAlt = rgb(${altForeground:1:6})"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.conf" "\$foregroundAlt2 = rgb(${foreground:1:6})" "\$foregroundAlt2 = rgb(${altForeground2:1:6})"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.conf" "\$backgroundAlt = rgb(${background:1:6})" "\$backgroundAlt = rgb(${altBackground:1:6})"
    _replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.conf" "\$backgroundAlt2 = rgb(${background:1:6})" "\$backgroundAlt2 = rgb(${altBackground2:1:6})"
}

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

_applyDunstTheme() {
    local background="$1"
    local altBackground="$2"
    local foreground="$3"
    local altBackground2="$4"
    local color1="$5"
    local color6="$6"

    _replaceHexColor "$DOTFILES/dunst/dunstrc" "53" "$altBackground"
    _replaceHexColor "$DOTFILES/dunst/dunstrc" "54" "$background"
    _replaceHexColor "$DOTFILES/dunst/dunstrc" "55" "$foreground"
    _replaceHexColor "$DOTFILES/dunst/dunstrc" "56" "$color1"
    _replaceHexColor "$DOTFILES/dunst/dunstrc" "64" "$altBackground2"
    _replaceHexColor "$DOTFILES/dunst/dunstrc" "73" "$color6"

    ## Reload the dunst
    pkill dunst &
    dunts &
}
