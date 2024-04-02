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

_replaceHexadecimalColorInLine() {
    local path=$1
    local word=$2
    local color=$3

    sed -i $path \
        -e "s/${word}=\"#\([0-9a-fA-F]\{3\}\|[0-9a-fA-F]\{6\}\|[0-9a-fA-F]\{8\}\)\"/${word}=\"${color}\"/g"
}

_replaceEightHexadecimalColorInLine() {
    local path=$1
    local word=$2
    local color=$3

    # Delete "#" symbol
    color=${color:1:6}

    # Replace color
    sed -i $path \
        -e "s/${word}=\([0-9a-fA-F]\{3\}\|[0-9a-fA-F]\{6\}\|[0-9a-fA-F]\{8\}\)/${word}=${color}ff/g"
}

# --------------------------------------------------------------
# Function: Replace some text into a file
# _replaceInFile $startMarket $endMarker $customtext $targetFile
# --------------------------------------------------------------

_replaceInFile() {
    # Set function parameters
    start_string=$1
    end_string=$2
    new_string="$3"
    file_path="$4"

    # Counters
    start_line_counter=0
    end_line_counter=0
    start_found=0
    end_found=0

    if [ -f $file_path ] ;then
        # Detect Start String
        while read -r line
        do
            ((start_line_counter++))
            if [[ $line = *$start_string* ]]; then
                # echo "Start found in $start_line_counter"
                start_found=$start_line_counter
                break
            fi 
        done < "$file_path"

        # Detect End String
        while read -r line
        do
            ((end_line_counter++))
            if [[ $line = *$end_string* ]]; then
                # echo "End found in $end_line_counter"
                end_found=$end_line_counter
                break
            fi 
        done < "$file_path"

        # Check that deliminters exists
        if [[ "$start_found" == "0" ]] ;then
	        notify-send -u critical "ERROR" "Start deliminter not found."
            sleep 2
        fi

        if [[ "$end_found" == "0" ]] ;then
            notify-send -u critical "ERROR" "End deliminter not found."
            sleep 2
        fi

        # Replace text between delimiters
        if [[ ! "$start_found" == "0" ]] && [[ ! "$end_found" == "0" ]] && [ "$start_found" -le "$end_found" ] ;then
            # Remove the old line
            ((start_found++))

            if [ ! "$start_found" == "$end_found" ] ;then    
                ((end_found--))
                sed -i "$start_found,$end_found d" $file_path
            fi
            # Add the new line
            sed -i "$start_found i $new_string" $file_path
        else
	        notify-send -u critical "ERROR" "Delimiters syntax."
            sleep 2
        fi
    else
	    notify-send -u critical "ERROR" "Target file not found."
        sleep 2
    fi
}

# ------------------------------------------------------
# Function: Replace an specific line in a file
# replaceLineInFile $findText $customtext $targetFile
# ------------------------------------------------------
_replaceLineInFile() {
    # Set function parameters
    find_string="$1"
    new_string="$2"
    file_path="$3"

    # Counters
    find_line_counter=0
    line_found=0

    if [ -f "$file_path" ]; then
        # Detect the line with find_string
        while IFS= read -r line; do
            ((find_line_counter++))
            if [[ $line = *$find_string* ]]; then
                line_found=$find_line_counter
                break
            fi
        done < "$file_path"

        if [[ ! "$line_found" == "0" ]]; then
            # Remove the line with new_string if it exists
            sed -i "/$new_string/d" "$file_path"
            # Remove the line with find_string
            sed -i "${line_found}d" "$file_path"
            # Add the new line
            sed -i "${line_found}i$new_string" "$file_path"
	    
	    echo -e "${CYAN}"
            echo "Line replaced in $file_path"
	    echo -e "${NOCOLOR}"
        else
            # If the line with find_string is not found, check if the line with new_string exists
            while IFS= read -r line; do
                ((find_line_counter++))
                if [[ $line = *$new_string* ]]; then
                    line_found=$find_line_counter
                    break
                fi
            done < "$file_path"
            
            if [[ ! "$line_found" == "0" ]]; then
                notify-send -u critical "ERROR" "The line with \"$find_string\" was not found but the line with \"$new_string\" already exists in $file_path"
            else
                notify-send -u critical "ERROR" "The line with \"$find_string\" was not found in $file_path"
		        exit 1
            fi
        fi
    else
    notify-send -u critical "ERROR" "Target file $file_path not found."

	exit 1
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

_applyDunstTemplate() {
    local tmpl_path=$1
    local dunst_path=$2

    # dunst : colors
    cat "${tmpl_path}/dunst/dunstrc" | envsubst > "${dunst_path}/dunstrc"

    # Reset dunst
    killall dunst;dunst &
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
        -e "s|\"months\": \"<span color='.\\+|\"months\": \"<span color='${foreground}'><b>{}</b></span>\",|g" \
        -e "s|\"days\": \"<span color='.\\+|\"days\": \"<span color='${color12}'>{}</span>\",|g" \
        -e "s|\"weekdays\": \"<span color='.\\+|\"weekdays\": \"<span color='${foreground}'><b>{}</b></span>\",|g" \
        -e "s|\"today\": \"<span color='.\\+|\"today\": \"<span color='${foreground}'><b>{}</b></span>\"|g"
	
    bash $script_file_path &
}

_applyWlogoutTemplate() {
    local tmpl_path=$1
    local wlog_path=$2
    local wlog_icons_path=$HOME/dotfiles/wlogout/icons

	# wlogout : colors (Is the same file as waybar)
	cat "${tmpl_path}/waybar/colors.css" | envsubst > "${wlog_path}/colors.css"

    # wlogout : icons theme
    _replaceHexadecimalColorInLine "${wlog_icons_path}/hibernate.svg" "fill" $foreground
    _replaceHexadecimalColorInLine "${wlog_icons_path}/lock.svg" "fill" $foreground
    _replaceHexadecimalColorInLine "${wlog_icons_path}/logout.svg" "stroke" $foreground
    _replaceHexadecimalColorInLine "${wlog_icons_path}/reboot.svg" "fill" $foreground
    _replaceHexadecimalColorInLine "${wlog_icons_path}/shutdown.svg" "fill" $foreground
    _replaceHexadecimalColorInLine "${wlog_icons_path}/suspend.svg" "fill" $foreground
}

_applyWofiTemplate() {
    local file_path=$1
    local dest_path=$2

    # Get corresponding lines from new content and old content
    local new_content=$(cat $file_path | grep @define)
    local old_content=$(cat $dest_path | grep @define)

    # Create arrays of lines for both contents
    IFS=$'\n' read -r -d '' -a new_lines <<< "$new_content"
    IFS=$'\n' read -r -d '' -a old_lines <<< "$old_content"

    # Iterate over each pair of corresponding lines
    for (( i=0; i<${#new_lines[@]}; i++ )); do
        new_line="${new_lines[i]}"
        old_line="${old_lines[i]}"
        
        _replaceLineInFile "$old_line" "$new_line" "$dest_path"
    done
}

_applyFuzzelTemplate() {
    local path=$1

    _replaceEightHexadecimalColorInLine "$path/fuzzel.ini" "background" $background
    _replaceEightHexadecimalColorInLine "$path/fuzzel.ini" "text" $foreground
    _replaceEightHexadecimalColorInLine "$path/fuzzel.ini" "match" $color4
    _replaceEightHexadecimalColorInLine "$path/fuzzel.ini" "selection" $modbackground1
    _replaceEightHexadecimalColorInLine "$path/fuzzel.ini" "selection-text" $foreground
    _replaceEightHexadecimalColorInLine "$path/fuzzel.ini" "selection-match" $color6
    _replaceEightHexadecimalColorInLine "$path/fuzzel.ini" "border" $modbackground2
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
