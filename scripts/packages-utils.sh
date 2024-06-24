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
# _checkIsInstalledPacman - Checks if a package is
# installed using pacman.
#
# Usage:
#   _checkIsInstalledPacman <package-name>
#
# Parameters:
#   package-name: The name of the package to check.
#
# Returns:
#   0 if the package is installed.
#   1 if the package is not installed.
#
# Example:
#   if _checkIsInstalledPacman "vim"; then
#       echo "Vim is installed."
#   else
#       echo "Vim is not installed."
#   fi
# -----------------------------------------------------
_checkIsInstalledPacman() {
    # Get the package name from the first argument
    local package="$1"

    # Check if the package is installed
    if pacman -Qq "$package" &>/dev/null; then
        echo 0 # true
        return
    else
        echo 1 # false
        return
    fi
}

# -----------------------------------------------------
# _installPackagesWithPacman - Installs packages using
# pacman.
#
# Usage:
#   _installPackagesWithPacman <packageName> [<packageName> ...]
#
# Parameters:
#   packageName: The name of the package to install.
#
# Example:
#   _installPackagesWithPacman "vim" "git"
# -----------------------------------------------------
_installPackagesWithPacman() {
    # Initialize an array to hold the names of packages that need to be installed
    packagesToInstall=()

    # Loop through all the arguments passed to the function (package names)
    for package in "$@"; do
        # Check if the package is already installed
        if [[ $(_checkIsInstalledPacman "${package}") == 0 ]]; then
            _message "info" "Package '${package}' is already installed"
        else
            # If not installed, add the package to the list
            packagesToInstall+=("${package}")
        fi
    done

    # Check if there are any packages that need to be installed
    if [[ ${#packagesToInstall[@]} -eq 0 ]]; then
        _message "info" "All pacman packages are already installed"
        return

    # Install the packages that are not yet installed
    else
        _message "info" "Installing pacman packages..."
        for package in "${packagesToInstall[@]}"; do
            sudo pacman -S --noconfirm "$package"

            # shellcheck disable=SC2181
            # Check if the package was installed successfully
            if [[ $? -eq 0 ]]; then
                _message "success" "Package '${package}' installed successfully"
            else
                _message "error" "Failed to install package '${package}'"
            fi
        done
    fi
}
