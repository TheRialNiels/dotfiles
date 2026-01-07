# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default aliases and functions
source ~/dotfiles/zshrc/.config/zsh/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

function start_if_needed() {
    if [[ $- == *i* ]] && [[ -z "${WM_VAR#/}" ]] && [[ -t 1 ]]; then
        exec $WM_CMD
    fi
}

start_if_needed

