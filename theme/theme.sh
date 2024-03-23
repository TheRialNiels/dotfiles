#!/bin/bash

# Directories
DIR="$HOME/dotfiles"

PATH_WALL="$DIR/wallpapers"
PATH_KITT="$DIR/kitty"
PATH_FOOT="$DIR/foot"
PATH_ROFI="$DIR/rofi"
PATH_WAYB="$DIR/waybar"
PATH_WLOG="$DIR/wlogout"
PATH_TMPL="$DIR/theme/templates"

# Hypr Scripts
HYPR_SCRIPTS="$DIR/hypr/scripts"

# Load utils script
source $DIR/theme/utils.sh

# Theme Sources
CURRENT_THEME="$DIR/theme/current.bash"
PYWAL_THEME="$HOME/.cache/wal/colors.sh"

# Wallpapers Variables
CACHE_WALL="$HOME/.cache/current_wallpaper"
CACHE_WALL_RASI="$HOME/.cache/current_wallpaper.rasi"
DEFAULT_WALL="$PATH_WALL/default.jpg"

_checkWallpapers $PATH_WALL

## Create cache_wall file if not exists
if [ ! -f $CACHE_WALL ] ;then
    touch $CACHE_WALL
    echo "$DEFAULT_WALL" > "$CACHE_WALL"
fi

## Create cache_wall_rasi file if not exists
if [ ! -f $CACHE_WALL_RASI ] ;then
    touch $CACHE_WALL_RASI
    echo "* { current-image: url(\"$DEFAULT_WALL\", height); }" > "$CACHE_WALL_RASI"
fi

current_wall=$(cat "$CACHE_WALL")

## Verify that pywal is installed
if [[ `which wal` ]]; then
    case $1 in
        "default")
            notification_msg="Applying default theme..."

            _applyPyWal "$notification_msg" "$DEFAULT_WALL"
        ;;

        "pywal")
            notification_msg="Generating colorscheme..."

            selected_image=$(_selectRandomImage "$PATH_WALL")
            _applyPyWal "$notification_msg" "$selected_image"
        ;;

        *)
            echo "Available Options: default  pywal"
		    exit 1
        ;;
    esac

    ## Get and generate colorscheme variables
    cat ${PYWAL_THEME} > ${CURRENT_THEME}
    source ${CURRENT_THEME}
    altbackground="`pastel color $background | pastel lighten 0.10 | pastel format hex`"
    altforeground="`pastel color $foreground | pastel darken 0.30 | pastel format hex`"
    modbackground=(`pastel gradient -n 3 $background $altbackground | pastel format hex`)
    accent="$color4"

    ## Export variables
    export background foreground accent color0 color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 color14 color15
    export modbackground1="${modbackground[1]}"
    export modbackground2="${modbackground[2]}"

    ## Copy coloschemes to the templates
    _updateWallpaper $wallpaper $CACHE_WALL "$HYPR_SCRIPTS/wallpaper.sh"
    _applyKittyTemplate $PATH_TMPL $PATH_KITT
    #TODO _applyFootTemplate $PATH_TMPL $PATH_FOOT
    #TODO _applyRofiTemplate $PATH_TMPL $PATH_ROFI
    _applyWaybarTemplate $PATH_TMPL $PATH_WAYB "$HYPR_SCRIPTS/statusbar.sh"
    #TODO _applyWlogoutTemplate $PATH_TMPL $PATH_WLOG
    _applyHyprTemplate
else
    #TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-runpywal -u normal -i ${PATH_MAKO}/icons/palette.png "'pywal' is not installed."
	exit
fi