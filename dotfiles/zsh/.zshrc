# -----------------------------------------------------
# Created by Zap installer
# -----------------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# -----------------------------------------------------
# Load Zsh Configuration
# -----------------------------------------------------

## ----------------------------
## Source Aliases
## ----------------------------
plug "$ZSH/config/aliases.zsh"

## ----------------------------
## Source Environment Variables
## ----------------------------
plug "$ZSH/config/env-variables.zsh"

## ----------------------------
## Source Plugins
## ----------------------------
plug "$ZSH/config/plugins.zsh"

## ----------------------------
## Source History Configuration
## ----------------------------
plug "$ZSH/config/history.zsh"

## ----------------------------
## Source Keybindings
## ----------------------------
plug "$ZSH/config/keybindings.zsh"

## ----------------------------
## Source General Configuration
## ----------------------------
plug "$ZSH/config/general.zsh"

## ----------------------------
## Source Functions
## ----------------------------
plug "$ZSH/config/functions.zsh"
