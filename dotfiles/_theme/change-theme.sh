#!/usr/bin/env bash

## Define Variables
SCRIPTS_DIR="../_scripts"
PATH_WALL="$DOTFILES/wallpapers"
PATH_TMPL="$DOTFILES/wal/templates"
PATH_PYWAL="$HOME/.cache/wal"

## Theme Variables
CURRENT_THEME="./current-theme.sh"
PYWAL_THEME="$HOME/.cache/wal/colors.sh"

## Wallpapers Variables
# TODO LOCK_SCREEN_WALL="$DIR/.settings/lock-screen.png"
CACHE_WALL_CURR="$HOME/.cache/current_wallpaper"
CACHE_WALL_RASI="$HOME/.cache/current_wallpaper.rasi"
DEFAULT_WALL_IMG="$PATH_WALL/default.jpg"

## Source Scripts
# shellcheck source=../_scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# shellcheck source=../_scripts/general-utils.sh
source "$SCRIPTS_DIR/general-utils.sh"

# shellcheck source=../_scripts/folders-utils.sh
source "$SCRIPTS_DIR/folders-utils.sh"

# shellcheck source=../_scripts/files-utils.sh
source "$SCRIPTS_DIR/files-utils.sh"

_checkWallpapers "$PATH_WALL"

## Create current wallpaper cache file if it does not exist
_createCacheFile "$CACHE_WALL_CURR" "$DEFAULT_WALL_IMG"

## Create current wallpaper rasi file if it does not exist
_createCacheFile "$CACHE_WALL_RASI" "* { current-image: url(\"$DEFAULT_WALL\", height); }"

## Verify that pywal is installed
if ! command -v wal &>/dev/null; then
    _message "error" "'Pywal' is not installed. Please install it before running this script."
    exit 1
fi

case $1 in
-d | --default)
    notiMsg="Applying default theme..."

    _applyTheme "$DEFAULT_WALL_IMG" "$notiMsg"

    # Convert jpg image extension to png image extension
    #TODO convert "$DEFAULT_WALL_IMG" "$LOCK_SCREEN_WALL"
    ;;

-r | --random)
    selectedWallpaper=$(find "$PATH_WALL" -type f | shuf -n 1)
    notiMsg="Applying random theme..."

    _applyTheme "$selectedWallpaper" "$notiMsg"

    # Convert jpg image extension to png image extension
    #TODO convert "$selectedWallpaper" "$LOCK_SCREEN_WALL"
    ;;

*)
    _message "error" "Valid options are: -d, --default, -r, --random."
    ;;
esac

## Get and generate the current theme
cat "$PYWAL_THEME" >"$CURRENT_THEME"
source "$CURRENT_THEME"

altBackground="$(pastel color "$background" | pastel lighten 0.10 | pastel format hex)"
altForeground="$(pastel color "$foreground" | pastel darken 0.10 | pastel format hex)"

## Replace the theme colors in the template files
_replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.sh" "foregroundAlt='$foreground'" "foregroundAlt='$altForeground'"
_replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.sh" "backgroundAlt='$background'" "backgroundAlt='$altBackground'"

_replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.css" "@define-color foregroundAlt $foreground;" "@define-color foregroundAlt $altForeground;"
_replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.css" "@define-color backgroundAlt $background;" "@define-color backgroundAlt $altBackground;"

_replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.conf" "\$foregroundAlt = rgb(${foreground:1:6})" "\$foregroundAlt = rgb(${altForeground:1:6})"
_replaceLineInTemplate "$PATH_TMPL" "$PATH_PYWAL" "colors.conf" "\$backgroundAlt = rgb(${background:1:6})" "\$backgroundAlt = rgb(${altBackground:1:6})"

mode=$2

## Copy the generated theme depending on the mode
case $mode in
dev)
    cp "$PATH_PYWAL/colors.css" "../waybar/colors.css"
    ;;
*)
    cp "$PATH_PYWAL/colors.css" "$DOTFILES/waybar/colors.css"
    ;;
esac
