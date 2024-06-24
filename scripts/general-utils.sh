#!/usr/bin/env bash
# -----------------------------------------------------
# General Utils
#
# This script contains general functions that can be
# used in other scripts.
#
# Made by TheRialNiels
# -----------------------------------------------------

# -----------------------------------------------------
# _updateSystem - Updates the system using pacman.
# -----------------------------------------------------
_updateSystem() {
    # Update the package list
    sudo pacman -Syu --noconfirm
}
