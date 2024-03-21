#!/bin/bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## launch waybar with alt config

CONFIG="$HOME/dotfiles/waybar/config"
STYLE="$HOME/dotfiles/waybar/style.css"

# Kill already running process
_ps=(waybar)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

if [[ ! `pidof waybar` ]]; then
	waybar --bar waybar --log-level error --config ${CONFIG} --style ${STYLE}
fi
