#!/usr/bin/env sh

## Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

## Set file variables using fd
wLayout="$DOTFILES/wlogout/layout"
wStyle="$DOTFILES/wlogout/style.css"

## Hypr var
hypr_border=$(hyprctl -j getoption decoration:rounding | jq '.int')
hypr_width=$(hyprctl -j getoption general:border_size | jq '.int')

## Detect monitor resolution
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sd '\.' '')

## Scale config layout and style
export x_mgn=$(( x_mon * 15 / hypr_scale ))
export y_mgn=$(( y_mon * 20 / hypr_scale ))
export x_hvr=$(( x_mon * 12 / hypr_scale ))
export y_hvr=$(( y_mon * 15 / hypr_scale ))
export x_fcs=$(( x_mon * 12 / hypr_scale ))
export y_fcs=$(( y_mon * 18 / hypr_scale ))

## Scale font size
export fntSize=$(( y_mon * 2 / 100 ))

## Eval hypr border radius
export active_rad=$(( hypr_border * 5 ))
export button_rad=$(( hypr_border * 8 ))

## Eval config files
wlStyle=$(envsubst < "$wStyle")

## Launch wlogout
wlogout -b 3 -c 0 -r 0 -m 0 --layout "$wLayout" --css <(echo "$wlStyle") --protocol layer-shell
