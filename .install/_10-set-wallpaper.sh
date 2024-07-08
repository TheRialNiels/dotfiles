#!/usr/bin/env bash
# -----------------------------------------------------
# Set Wallpaper
#
# This script sets the wallpaper cache files.
# -----------------------------------------------------

## Define Variables
walCacheDir="$HOME/.cache/wallpaper"
walCacheFile="$walCacheDir/current_wallpaper"
walRasiCacheFile="$walCacheDir/current_wallpaper.rasi"
defaultWallpaper="$DOTFILES/wallpapers/default.jpg"

## Create Wallpaper Cache Directory
_createDirectoryIfNotExists "$walCacheDir"

## Create Wallpaper Cache File
_createCacheFile "$walCacheFile" "$defaultWallpaper"

## Create Wallpaper Rasi Cache File
rasiContent="* { current-image: url(\"$defaultWallpaper\", height); }"
_createCacheFile "$walRasiCacheFile" "$rasiContent"
