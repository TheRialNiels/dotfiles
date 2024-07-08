#!/usr/bin/env bash
# -----------------------------------------------------
# Install Required Packages
#
# This script installs the required packages for the
# dotfiles.
# -----------------------------------------------------

# Check if the mode is prod
if [[ "$MODE" == "prod" ]]; then
    ## 1.1 Update System
    _message "info" "Updating system..."
    _updateSystem

    ## 1.2 Install Rustup
    if command -v rustc &>/dev/null; then
        _message "info" "Rust is already installed!"
        _message "info" "Checking for rust updates..."
        sudo pacman -Syu rustup --noconfirm

        # shellcheck disable=SC2181
        if [[ $? -eq 0 ]]; then
            _message "success" "Rust updated successfully!"
        else
            _message "error" "Rust update failed!"
            exit 1 # Return error
        fi
    else
        _message "info" "Installing required packages..."
        _installPackagesWith "pacman" "curl" "cmake"

        _message "info" "Installing rustup..."
        _installPackagesWith "pacman" "rustup"

        _message "info" "Installing Rust toolchain..."
        rustup default stable

        # shellcheck disable=SC2181
        if [[ $? -ne 0 ]]; then
            _message "error" "Installing Rust toolchain failed!"
            exit 1 # Return error
        fi

        _message "info" "Updating Rust toolchain..."
        rustup update stable

        # shellcheck disable=SC2181
        if [[ $? -ne 0 ]]; then
            _message "error" "Updating Rust toolchain failed!"
            exit 1 # Return error
        fi

        _message "info" "Verifying Rust installation..."
        if command -v rustc &>/dev/null; then
            _message "success" "Rust installed successfully!"
        else
            _message "error" "Rust installation failed!"
            exit 1 # Return error
        fi
    fi

    ## 1.3 Install Required Packages
    _message "info" "Installing required packages..."

    # shellcheck source="../.install/packages/required-packages.sh"
    source "$PACKAGES_DIR/required-packages.sh"

    _installPackagesWith "pacman" "${requiredPackagesPacman[@]}"

    ## 1.4 Update /etc/pacman.conf file
    _message "info" "Updating /etc/pacman.conf file..."
    _replaceLineIfUnchanged "/etc/pacman.conf" "#Color" "Color" true
    _replaceLineIfUnchanged "/etc/pacman.conf" "#ParallelDownloads = 5" "ParallelDownloads = 3" true
fi
