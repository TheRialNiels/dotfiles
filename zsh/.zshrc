## ----- ZSH HOME ------------------------------
export ZSH=$HOME/zsh/

## ----- Created by Zap installer ------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

## ----- Source ------------------------------
plug "$HOME/dotfiles/zsh/config/aliases.zsh"

## ----- Env Variables ------------------------------
plug "$HOME/dotfiles/zsh/config/env-variables.zsh"

## ----- Plugins ------------------------------
plug "$HOME/dotfiles/zsh/config/plugins.zsh"

## ----- History ------------------------------
plug "$HOME/dotfiles/zsh/config/history.zsh"

## ----- Keybindings ------------------------------
plug "$HOME/dotfiles/zsh/config/keybindings.zsh"

## ----- General ------------------------------
plug "$HOME/dotfiles/zsh/config/general.zsh"
