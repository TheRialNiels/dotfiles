#!/usr/bin/env bash

# -----------------------------------------------------
# Launch Waybar
# -----------------------------------------------------

## Quit all running instances of Waybar
killall waybar
pkill waybar
sleep 0.2

## TODO - Add script to define sensors

## Define the Waybar configuration files
config="$DOTFILES/waybar/config.jsonc"
style="$DOTFILES/waybar/style.css"

## Launch Waybar with the specified configuration
waybar --log-level error -c "$config" -s "$style"
