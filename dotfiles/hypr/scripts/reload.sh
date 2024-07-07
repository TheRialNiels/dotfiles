#!/usr/bin/env bash

# -----------------------------------------------------
# Reload the configuration for Hypr
# -----------------------------------------------------

# Reload the configuration
hyprctl reload

# Relaunch Waybar
$DOTFILES/waybar/launch.sh

notify-send "Hypr Reload" "Configuration reloaded"
