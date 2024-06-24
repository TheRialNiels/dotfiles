#!/usr/bin/env bash
# -----------------------------------------------------
# Install Script
#
# This script installs the required packages and tools
# for the dotfiles to work properly.
#
# Made by TheRialNiels
# -----------------------------------------------------

## Define Variables
export VERSION
export DOTFILES_SCRIPT_PATH
export SCRIPTS_DIR="scripts"
export INST_PATH="./.install"
export PACKAGES_DIR="$INST_PATH/packages"
export DOTFILES="$HOME/dotfiles"

VERSION="$(cat .version)"
#DOTFILES_SCRIPT_PATH="$(dirname "$(realpath "$0")")"

## Define Mode
export MODE
if [[ "$1" == "dev" ]]; then
    MODE="dev"
else
    MODE="prod"
fi

## Source Utils
# shellcheck source=scripts/source-utils.sh
source "$SCRIPTS_DIR/source-utils.sh"

## 1. Install Required Packages
# shellcheck source=.install/_1-install-req-pkgs.sh
source "$INST_PATH/_1-install-req-pkgs.sh"

## Show Title
# shellcheck source=scripts/print-title.sh
source "$SCRIPTS_DIR/print-title.sh"

## 2. Confirm Installation
# shellcheck source=.install/_2-confirm-installation.sh
source "$INST_PATH/_2-confirm-installation.sh"

## 3. Install Yay
# shellcheck source=.install/_3-install-yay.sh
source "$INST_PATH/_3-install-yay.sh"

## 4. Backup Previous Dotfiles
# shellcheck source=.install/_4-backup-dotfiles.sh
source "$INST_PATH/_4-backup-dotfiles.sh"

## 5. Prepare Dotfiles
# shellcheck source=.install/_5-prepare-dotfiles.sh
source "$INST_PATH/_5-prepare-dotfiles.sh"
