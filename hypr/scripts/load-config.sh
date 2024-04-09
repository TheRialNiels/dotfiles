#!/bin/bash

hyprctl reload

pypr reload

source ~/.zshenv

# Lauch statusbar (waybar)
$HOME/dotfiles/hypr/scripts/statusbar.sh &
