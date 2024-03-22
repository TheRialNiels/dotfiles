#!/bin/bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## Script To Apply Themes

## Theme ------------------------------------
DIR="$HOME/dotfiles"

## Directories ------------------------------
PATH_KITT="$DIR/kitty"
PATH_FOOT="$DIR/foot"
PATH_ROFI="$DIR/rofi"
PATH_WAYB="$DIR/waybar"
PATH_WLOG="$DIR/wlogout"
PATH_TMPL="$DIR/theme/templates"

## Source Theme File ------------------------
CURRENT_THEME="$DIR/theme/current.bash"
DEFAULT_THEME="$DIR/theme/default.bash"
PYWAL_THEME="$HOME/.cache/wal/colors.sh"

## Check if current file exist
if [[ ! -e "$CURRENT_THEME" ]]; then
	touch "$CURRENT_THEME"
fi

## Default Theme
source_default() {
	cat ${DEFAULT_THEME} > ${CURRENT_THEME}
	source ${CURRENT_THEME}
	altbackground="`pastel color $background | pastel lighten 0.10 | pastel format hex`"
	altforeground="`pastel color $foreground | pastel darken 0.30 | pastel format hex`"
	modbackground=(`pastel gradient -n 3 $background $altbackground | pastel format hex`)
	accent="$color5"
	#TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-dtheme -u normal -i ${PATH_MAKO}/icons/palette.png "Applying Default Theme..."
}

## Random Theme
source_pywal() {
	# Set you wallpaper directory here.
	WALLDIR="$DIR/wallpapers"

	# Check for wallpapers
	check_wallpaper() {
		if [[ -d "$WALLDIR" ]]; then
			WFILES="`ls --format=single-column $WALLDIR | wc -l`"
			if [[ "$WFILES" == 0 ]]; then
				#TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-noimg -u low -i ${PATH_MAKO}/icons/picture.png "There are no wallpapers in : $WALLDIR"
				exit
			fi
		else
			mkdir -p "$WALLDIR"
			#TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-noimg -u low -i ${PATH_MAKO}/icons/picture.png "Put some wallpapers in : $WALLDIR"
			exit
		fi
	}

	# Run `pywal` to generate colors
	generate_colors() {
		check_wallpaper
		if [[ `which wal` ]]; then
			#TODO (Send notification) notify-send -t 50000 -h string:x-canonical-private-synchronous:sys-notify-runpywal -i ${PATH_MAKO}/icons/timer.png "Generating Colorscheme. Please wait..."
			wal -q -n -s -t -e -i "$WALLDIR"
			if [[ "$?" != 0 ]]; then
				#TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-runpywal -u normal -i ${PATH_MAKO}/icons/palette.png "Failed to generate colorscheme."
				exit
			fi
		else
			#TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-runpywal -u normal -i ${PATH_MAKO}/icons/palette.png "'pywal' is not installed."
			exit
		fi
	}

	generate_colors
	cat ${PYWAL_THEME} > ${CURRENT_THEME}
	source ${CURRENT_THEME}
	altbackground="`pastel color $background | pastel lighten 0.10 | pastel format hex`"
	altforeground="`pastel color $foreground | pastel darken 0.30 | pastel format hex`"
	modbackground=(`pastel gradient -n 3 $background $altbackground | pastel format hex`)
	accent="$color4"
}

## Wallpaper ---------------------------------
apply_wallpaper() {
	sed -i -e "s#WALLPAPER=.*#WALLPAPER='$wallpaper'#g" ${DIR}/hypr/scripts/wallpaper.sh
	bash ${DIR}/hypr/scripts/wallpaper.sh &
}

## Kitty ---------------------------------
apply_kitty() {
    # kitty : colors
    cat "${PATH_TMPL}/kitty/color.ini" | envsubst > "${PATH_KITT}/color.ini"
}

## Foot --------------------------------------
apply_foot() {
	# foot : colors
	process_template "${PATH_TMPL}/foot/colors.ini" > "${PATH_FOOT}/colors.ini"
}

## Rofi --------------------------------------
apply_rofi() {
	# rofi : colors
	cat "${PATH_TMPL}/rofi/colors.rasi" > "${PATH_ROFI}/theme/colors.rasi"
}

## Waybar ------------------------------------
apply_waybar() {
	# waybar : colors
	cat "${PATH_TMPL}/waybar/colors.css" | envsubst > "${PATH_WAYB}/colors.css"
	sleep 1
	bash ${DIR}/hypr/scripts/statusbar.sh &
}

## Wlogout -----------------------------------
apply_wlogout() {
	# wlogout : colors
	cat "${PATH_TMPL}/waybar/colors.css" | envsubst > "${PATH_WLOG}/colors.css"
}

## Hyprland --------------------------------------
apply_hypr() {
	# hyprland : theme
	sed -i ${DIR}/hypr/hyprtheme.conf \
		-e "s/\$active_border_col_1 =.*/\$active_border_col_1 = 0xFF${accent:1}/g" \
		-e "s/\$active_border_col_2 =.*/\$active_border_col_2 = 0xFF${color1:1}/g" \
		-e "s/\$inactive_border_col_1 =.*/\$inactive_border_col_1 = 0xFF${modbackground[1]:1}/g" \
		-e "s/\$inactive_border_col_2 =.*/\$inactive_border_col_2 = 0xFF${modbackground[2]:1}/g" \
		-e "s/\$group_border_col =.*/\$group_border_col = 0xFF${color1:1}/g" \
		-e "s/\$group_border_active_col =.*/\$group_border_active_col = 0xFF${color2:1}/g"
}

## Replace custom colors variable (eg. color0:1)
process_template() {
    local template_file="$1"
    local output_file="$2"

    # Read the content of the template and process it
    while IFS= read -r line; do
        # Replace variables according to your needs
        for ((i=0; i<=15; i++)); do
            line="${line//\${color${i}:1}/${!color${i}:1}}"
        done
        # You can add more replacements as needed

        # Write the processed line to the output file
        echo "$line" >> "$output_file"
    done < "$template_file"
}

## Source Theme Accordingly -----------------
if [[ "$1" == '--default' ]]; then
	source_default
elif [[ "$1" == '--pywal' ]]; then
	source_pywal
else
	echo "Available Options: --default  --pywal"
	exit 1
fi

## Export variables
export background foreground accent color0 color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 color14 color15
export modbackground1="${modbackground[1]}"
export modbackground2="${modbackground[2]}"

## Execute Script ---------------------------
apply_wallpaper
apply_kitty
#TODO apply_foot
#TODO apply_rofi
apply_waybar
#TODO apply_wlogout
apply_hypr