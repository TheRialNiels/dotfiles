#!/usr/bin/env bash

#
# by Stephan Raabe (2023)
# -----------------------------------------------------

# ------------------------------------------------------
# Function: Is package installed
# ------------------------------------------------------
_isInstalledPacman() {
    package="$1"
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
    if [ -n "${check}" ]; then
        echo 0 #'0' means 'true' in Bash
        return #true
    fi
    echo 1 #'1' means 'false' in Bash
    return #false
}

_isInstalledYay() {
    package="$1"
    check="$(yay -Qs --color always "${package}" | grep "local" | grep "\." | grep "${package} ")"
    if [ -n "${check}" ]; then
        echo 0 #'0' means 'true' in Bash
        return #true
    fi
    echo 1 #'1' means 'false' in Bash
    return #false
}

_isFolderEmpty() {
    folder="$1"
    if [ -d $folder ]; then
        if [ -z "$(ls -A $folder)" ]; then
            echo 0
        else
            echo 1
        fi
    else
        echo 1
    fi
}

# ------------------------------------------------------
# Function Install all package if not installed
# ------------------------------------------------------
_installPackagesPacman() {
    toInstall=()
    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            _changeTextColor "$WHITE" ":: ${pkg} is already installed"
            continue
        fi
        toInstall+=("${pkg}")
    done

    if [[ "${toInstall[*]}" == "" ]]; then
        # echo "All pacman packages are already installed.";
        return
    fi

    # printf "Package not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}"
}

_forcePackagesPacman() {
    toInstall=()
    for pkg; do
        toInstall+=("${pkg}")
    done

    if [[ "${toInstall[*]}" == "" ]]; then
        # echo "All pacman packages are already installed.";
        return
    fi

    # printf "Package not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}" --ask 4
}

_installPackagesYay() {
    toInstall=()
    for pkg; do
        if [[ $(_isInstalledYay "${pkg}") == 0 ]]; then
            _changeTextColor "$WHITE" ":: ${pkg} is already installed"
            continue
        fi
        toInstall+=("${pkg}")
    done

    if [[ "${toInstall[*]}" == "" ]]; then
        # echo "All packages are already installed.";
        return
    fi

    # printf "AUR packags not installed:\n%s\n" "${toInstall[@]}";
    yay --noconfirm -S "${toInstall[@]}"
}

_forcePackagesYay() {
    toInstall=()
    for pkg; do
        toInstall+=("${pkg}")
    done

    if [[ "${toInstall[*]}" == "" ]]; then
        # echo "All packages are already installed.";
        return
    fi

    # printf "AUR packags not installed:\n%s\n" "${toInstall[@]}";
    yay --noconfirm -S "${toInstall[@]}" --ask 4
}

# ------------------------------------------------------
# Function: Create symbolic links
# ------------------------------------------------------
_installSymLink() {
    symlink="$1"
    linksource="$2"
    linktarget="$3"

    if [ -L "${symlink}" ]; then
        rm "${symlink}"
        ln -s "${linksource}" "${linktarget}"
        _showSuccessMsg "Symlink $(_changeTextColor "$WHITE" "$linksource") -> $(_changeTextColor "$WHITE" "$linktarget") created"
    else
        if [ -d "${symlink}" ]; then
            rm -rf "${symlink}/"
            ln -s "${linksource}" "${linktarget}"
            _showSuccessMsg "Symlink for directory $(_changeTextColor "$WHITE" "$linksource") -> $(_changeTextColor "$WHITE" "$linktarget") created"
        else
            if [ -f "${symlink}" ]; then
                rm "${symlink}"
                ln -s "${linksource}" "${linktarget}"
                _showSuccessMsg "Symlink to file $(_changeTextColor "$WHITE" "$linksource") -> $(_changeTextColor "$WHITE" "$linktarget") created."
            else
                ln -s "${linksource}" "${linktarget}"
                _showSuccessMsg "New symlink $(_changeTextColor "$WHITE" "$linksource") -> $(_changeTextColor "$WHITE" "$linktarget") created."
            fi
        fi
    fi
}

# --------------------------------------------------------------
# Function: Replace some text into a file
# _replaceInFile $startMarket $endMarker $customtext $targetFile
# --------------------------------------------------------------
_replaceInFile() {
    # Set function parameters
    start_string="$1"
    end_string="$2"
    new_string="$3"
    file_path="$4"

    # Counters
    start_line_counter=0
    end_line_counter=0
    start_found=0
    end_found=0

    if [ -f $file_path ]; then
        # Detect Start String
        while read -r line; do
            ((start_line_counter++))
            if [[ $line = *$start_string* ]]; then
                # echo "Start found in $start_line_counter"
                start_found=$start_line_counter
                break
            fi
        done <"$file_path"

        # Detect End String
        while read -r line; do
            ((end_line_counter++))
            if [[ $line = *$end_string* ]]; then
                # echo "End found in $end_line_counter"
                end_found=$end_line_counter
                break
            fi
        done <"$file_path"

        # Check that deliminters exists
        if [[ "$start_found" == "0" ]]; then
            _showErrorMsg "Start deliminter not found"
            sleep 2
        fi

        if [[ "$end_found" == "0" ]]; then
            _showErrorMsg "End deliminter not found"
            sleep 2
        fi

        # Replace text between delimiters
        if [[ ! "$start_found" == "0" ]] && [[ ! "$end_found" == "0" ]] && [ "$start_found" -le "$end_found" ]; then
            # Remove the old line
            ((start_found++))

            if [ ! "$start_found" == "$end_found" ]; then
                ((end_found--))
                sed -i "$start_found,$end_found d" $file_path
            fi
            # Add the new line
            sed -i "$start_found i $new_string" $file_path
        else
            _showErrorMsg "Delimiters syntax"
            sleep 2
        fi
    else
        _showErrorMsg "Target file not found"
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
        done <"$file_path"

        if [[ ! "$line_found" == "0" ]]; then
            # Remove the line with new_string if it exists
            sed -i "/$new_string/d" "$file_path"
            # Remove the line with find_string
            sed -i "${line_found}d" "$file_path"
            # Add the new line
            sed -i "${line_found}i$new_string" "$file_path"

            _showSuccessMsg "Line replaced in $(_changeTextColor "$WHITE" "$file_path")"
        else
            # If the line with find_string is not found, check if the line with new_string exists
            while IFS= read -r line; do
                ((find_line_counter++))
                if [[ $line = *$new_string* ]]; then
                    line_found=$find_line_counter
                    break
                fi
            done <"$file_path"

            if [[ ! "$line_found" == "0" ]]; then
                _showInfoMsg "The line with \"$(_changeTextColor "$WHITE" "$find_string")\" was not found but the line with \"$(_changeTextColor "$WHITE" "$new_string")\" already exists in $(_changeTextColor "$WHITE" "$file_path")"
            else
                _showErrorMsg "The line with \"$(_changeTextColor "$WHITE" "$find_string")\" was not found in $(_changeTextColor "$WHITE" "$file_path")"

                exit 1
            fi
        fi
    else
        _showErrorMsg "Target file $(_changeTextColor "$WHITE" "$file_path") not found"

        exit 1
    fi
}

# ------------------------------------------------------
# Functions: Give color to an specific text
# ------------------------------------------------------
_showSuccessMsg() {
    message="$1"

    echo -e "${GREEN}:: SUCCESS => ${NOCOLOR}${message}\n"
}

_showErrorMsg() {
    message="$1"

    echo -e "${RED}:: ERROR => ${NOCOLOR}${message}\n"
}

_showWarningMsg() {
    message="$1"

    echo -e "${YELLOW}:: WARNING => ${NOCOLOR}${message}\n"
}

_showInfoMsg() {
    message="$1"

    echo -e "${CYAN}:: INFO => ${NOCOLOR}${message}\n"
}

_changeTextColor() {
    color="$1"
    text="$2"

    echo -e "${color}${text}${NOCOLOR}\n"
}
