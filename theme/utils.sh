_checkWallpapers() {
    local path=$1

	if [[ -d "$path" ]]; then
		files="`ls --format=single-column $path | wc -l`"
		if [[ "$files" == 0 ]]; then
			#TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-noimg -u low -i ${PATH_MAKO}/icons/picture.png "There are no wallpapers in : $path"
            notify-send "There are no wallpapers in : $path"
			exit
		fi
	else
		mkdir -p "$path"
		#TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-noimg -u low -i ${PATH_MAKO}/icons/picture.png "Put some wallpapers in : $path"
        notify-send "Put some wallpapers in : $path"
		exit
	fi
}

_applyPyWal() {
    local notification_msg=$1
    local folder_image_path=$2

    #TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-dtheme -u normal -i ${PATH_MAKO}/icons/palette.png "Applying Default Theme..."
    notify-send "$notification_msg"
    wal -q -n -s -t -e -i $folder_image_path

    if [[ "$?" != 0 ]]; then
        #TODO (Send notification) notify-send -h string:x-canonical-private-synchronous:sys-notify-runpywal -u normal -i ${PATH_MAKO}/icons/palette.png "Failed to generate colorscheme."
        notify-send "Failed to generate colorscheme"
        exit
    fi
}

_selectRandomImage() {
    local folder_path="$1"
    local images=()

    # Iterate through the files in the folder
    for file in "$folder_path"/*; do
        # Check if the file is an image (jpg, jpeg, or png extension)
        if [[ $file =~ \.(jpg|jpeg|png)$ ]]; then
            images+=("$file")
        fi
    done

    # Check if any images were found in the folder
    if [[ ${#images[@]} -eq 0 ]]; then
        #TODO Add style to the notification
        notify-send "No wallpapers found in $folder_path"
        echo "No Wallpapers"
    else
        # Select a random image from the list
        local selected_image="${images[RANDOM % ${#images[@]}]}"
        echo "$selected_image"
    fi
}

## Replace custom colors variable (eg. color0:1)
_processTemplate() {
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

_updateWallpaper() {
    local wallpaper=$1
    local destination_file=$2
    local script_file_path=$3

    echo "$wallpaper" > "$destination_file"
	bash $script_file_path &
}

_applyKittyTemplate() {
    local tmpl_path=$1
    local kitty_path=$2

    # kitty : colors
    cat "${tmpl_path}/kitty/color.ini" | envsubst > "${kitty_path}/color.ini"
}

_applyFootTemplate() {
    local tmpl_path=$1
    local foot_path=$2

	# foot : colors
	process_template "${tmpl_path}/foot/colors.ini" > "${foot_path}/colors.ini"
}

_applyRofiTemplate() {
    local tmpl_path=$1
    local rofi_path=$2

	# rofi : colors
	cat "${tmpl_path}/rofi/colors.rasi" > "${rofi_path}/theme/colors.rasi"
}

_applyWaybarTemplate() {
    local tmpl_path=$1
    local wayb_path=$2
    local script_file_path=$3

	# waybar : colors
	cat "${tmpl_path}/waybar/colors.css" | envsubst > "${wayb_path}/colors.css"
	sleep 1
    
    # waybar clock module : colors
    sed -i "${HOME}/dotfiles/waybar/general-modules/clock.json" \
        -e "s|\"months\": \"<span color='.\\+|\"months\": \"<span color='${color14}'><b>{}</b></span>\",|g" \
        -e "s|\"days\": \"<span color='.\\+|\"days\": \"<span color='${color12}'>{}</span>\",|g" \
        -e "s|\"weekdays\": \"<span color='.\\+|\"weekdays\": \"<span color='${color14}'><b>{}</b></span>\",|g" \
        -e "s|\"today\": \"<span color='.\\+|\"today\": \"<span color='${foreground}'><b>{}</b></span>\"|g"
	
    bash $script_file_path &
}

_applyWlogoutTemplate() {
    local tmpl_path=$1
    local wlog_path=$2

	# wlogout : colors (Is the same file as waybar)
	cat "${tmpl_path}/waybar/colors.css" | envsubst > "${wlog_path}/colors.css"
}

_applyHyprTemplate() {
	# hyprland : theme
	sed -i ~/dotfiles/hypr/hyprtheme.conf \
		-e "s/\$active_border_col_1 =.*/\$active_border_col_1 = 0xFF${accent:1}/g" \
		-e "s/\$active_border_col_2 =.*/\$active_border_col_2 = 0xFF${color1:1}/g" \
		-e "s/\$inactive_border_col_1 =.*/\$inactive_border_col_1 = 0xFF${modbackground[1]:1}/g" \
		-e "s/\$inactive_border_col_2 =.*/\$inactive_border_col_2 = 0xFF${modbackground[2]:1}/g" \
		-e "s/\$group_border_col =.*/\$group_border_col = 0xFF${color1:1}/g" \
		-e "s/\$group_border_active_col =.*/\$group_border_active_col = 0xFF${color2:1}/g"
}
