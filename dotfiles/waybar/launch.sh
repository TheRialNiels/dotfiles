#!/usr/bin/env bash

# -----------------------------------------------------
# Launch Waybar
# -----------------------------------------------------

## Quit all running instances of Waybar
killall waybar
pkill waybar
sleep 0.2

## Define the Waybar configuration files
config="$DOTFILES/waybar/config.jsonc"
style="$DOTFILES/waybar/style.css"

## Launch Waybar with the specified configuration
waybar -c "$config" -s "$style" &
