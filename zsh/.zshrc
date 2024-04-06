## ----- Created by Zap installer ------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

## ----- Source ------------------------------
plug "$ZSH/config/aliases.zsh"

## ----- Env Variables ------------------------------
plug "$ZSH/config/env-variables.zsh"

## ----- Plugins ------------------------------
plug "$ZSH/config/plugins.zsh"

## ----- History ------------------------------
plug "$ZSH/config/history.zsh"

## ----- Keybindings ------------------------------
plug "$ZSH/config/keybindings.zsh"

## ----- General ------------------------------
plug "$ZSH/config/general.zsh"

## ----- Functions ------------------------------
plug "$ZSH/config/functions.zsh"
