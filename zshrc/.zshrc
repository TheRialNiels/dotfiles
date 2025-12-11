eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt beep nomatch
unsetopt autocd extendedglob

bindkey -v

zstyle :compinstall filename '${HOME}/.zshrc'

autoload -Uz compinit
compinit

