#!/bin/bash

hyprctl reload

pypr reload

# Lauch statusbar (waybar)
$HOME/dotfiles/hypr/scripts/statusbar.sh &
