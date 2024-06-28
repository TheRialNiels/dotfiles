#!/usr/bin/env bash
# -----------------------------------------------------
# Packages Utils
#
# This script contains functions to check if a package
# is installed and to install packages using pacman.
#
# Made by TheRialNiels
# -----------------------------------------------------

# shellcheck source=../scripts/messages-utils.sh
source "$SCRIPTS_DIR/messages-utils.sh"

# -----------------------------------------------------
# _checkIsInstalledWith - Checks if a package is installed
# using yay or pacman.
#
# Usage:
#   _checkIsInstalledWith <packageManager> <packageName>
#
# Parameters:
#   packageManager: The package manager to use ("yay" or "pacman").
#   packageName: The name of the package to check.
#
# Returns:
#   0 if the package is installed.
#   1 if the package is not installed.
#
# Example:
#   if _checkIsInstalledWith "pacman" "vim"; then
#       echo "Vim is installed."
#   else
#       echo "Vim is not installed."
#   fi
# -----------------------------------------------------
_checkIsInstalledWith() {
    local packageManager=$1
    local package=$2

    # Check if the package is installed using the specified package manager
    if [[ "$packageManager" == "yay" ]]; then
        if yay -Qq "$package" &>/dev/null; then
            echo "0" # true
            return
        else
            echo "1" # false
            return
        fi
    elif [[ "$packageManager" == "pacman" ]]; then
        if pacman -Qq "$package" &>/dev/null; then
            echo "0" # true
            return
        else
            echo "1" # false
            return
        fi
    else
        _message "error" "Invalid package manager '${packageManager}'"
        return 1
    fi
}

# -----------------------------------------------------
# _installPackagesWith - Installs packages using yay or pacman.
#
# Usage:
#   _installPackagesWith <packageManager> <packageName> [<packageName> ...]
#
# Parameters:
#   packageManager: The package manager to use ("yay" or "pacman").
#   packageName: The name of the package to install.
#
# Example:
#   _installPackagesWith "yay" "vim" "git"
#   _installPackagesWith "pacman" "vim" "git"
# -----------------------------------------------------
_installPackagesWith() {
    local packageManager=$1
    shift  # Remove the first argument, so that "$@" contains only package names

    # Initialize an array to hold the names of packages that need to be installed
    packagesToInstall=()

    # Loop through all the arguments passed to the function (package names)
    for package in "$@"; do
        # Check if the package is already installed based on the package manager
        if _checkIsInstalledWith "$packageManager" "$package"; then
            _message "info" "Package '${package}' is already installed"
        else
            packagesToInstall+=("${package}")
        fi
    done

    # Check if there are any packages that need to be installed
    if [[ ${#packagesToInstall[@]} -eq 0 ]]; then
        _message "info" "All ${packageManager} packages are already installed"
        return
    else
        _message "info" "Installing ${packageManager} packages..."
        for package in "${packagesToInstall[@]}"; do
            if [[ "$packageManager" == "yay" ]]; then
                yay -S --noconfirm "$package"
            elif [[ "$packageManager" == "pacman" ]]; then
                sudo pacman -S --noconfirm "$package"
            fi

            # Check if the package was installed successfully
            if [[ $? -eq 0 ]]; then
                _message "success" "Package '${package}' installed successfully"
            else
                _message "error" "Failed to install package '${package}'"
            fi
        done
    fi
}
