#!/usr/bin/env bash

## Define Variables
SCRIPTS_DIR="$DOTFILES/_scripts"
THEME_DIR="$DOTFILES/_theme"
HYPR_SCRIPTS_DIR="$DOTFILES/hypr/scripts"
PATH_WALL="$DOTFILES/wallpapers"
PATH_TMPL="$DOTFILES/wal/templates"
PATH_PYWAL="$HOME/.cache/wal"

## Theme Variables
CURRENT_THEME="$DOTFILES/_theme/current-theme.sh"
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

# shellcheck source=./utils.sh
source "$THEME_DIR/utils.sh"

_checkWallpapers "$PATH_WALL"

## Create current wallpaper cache file if it does not exist
_createCacheFile "$CACHE_WALL_CURR" "$DEFAULT_WALL_IMG"

## Create current wallpaper rasi file if it does not exist
_createCacheFile "$CACHE_WALL_RASI" "* { current-image: url(\"$DEFAULT_WALL\", height); }"

## Verify that pywal is installed
if ! command -v wal &>/dev/null; then
    notify-send "Pywal is not installed. Please install it before running this script."
    _message "error" "'Pywal' is not installed. Please install it before running this script."
    exit 1
fi

case $1 in
-d | --default)
    notiMsg="Applying default theme..."

    _applyTheme "$DEFAULT_WALL_IMG" "$notiMsg"

    # Update the wallpaper cache files
    _updateWallpaperCacheFiles "$DEFAULT_WALL_IMG"

    # Setup the new wallpaper
    bash "$HYPR_SCRIPTS_DIR/setup-wallpaper.sh" "$DEFAULT_WALL_IMG"

    # Convert jpg image extension to png image extension
    #TODO convert "$DEFAULT_WALL_IMG" "$LOCK_SCREEN_WALL"
    ;;

-r | --random)
    selectedWallpaper=$(find "$PATH_WALL" -type f | shuf -n 1)
    notiMsg="Applying random theme..."

    _applyTheme "$selectedWallpaper" "$notiMsg"

    # Update the wallpaper cache files
    _updateWallpaperCacheFiles "$selectedWallpaper"

    # Setup the new wallpaper
    bash "$HYPR_SCRIPTS_DIR/setup-wallpaper.sh" "$selectedWallpaper" &

    # Convert jpg image extension to png image extension
    #TODO convert "$selectedWallpaper" "$LOCK_SCREEN_WALL"
    ;;

*)
    _message "error" "Valid options are: -d, --default, -r, --random."
    ;;
esac

## Get and generate the current theme
cat "$PYWAL_THEME" >"$CURRENT_THEME"

# shellcheck source=./current-theme.sh
source "$CURRENT_THEME"

altBackground="$(pastel color "$background" | pastel lighten 0.10 | pastel format hex)"
altBackground2="$(pastel gradient -n 3 "$background" "$altBackground" | pastel format hex | awk 'NR==2')"
altForeground="$(pastel color "$foreground" | pastel darken 0.10 | pastel format hex)"
altForeground2="$(pastel gradient -n 3 "$foreground" "$altForeground" | pastel format hex | awk 'NR==2')"

## Replace the theme colors in the template files
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

## Copy the generated theme depending on the mode
cp "$PATH_PYWAL/colors.css" "$DOTFILES/waybar/colors.css"

_applyWaybarTheme "$color1" "$altForeground"
