# -----------------------------------------------------
# Export Environment Variables
# -----------------------------------------------------

## ----------------------------
## Apply GTK Theme to QT Apps
## ----------------------------
#export QT_QPA_PLATFORMTHEME='gnome'

## ----------------------------
## FZF Colors
## ----------------------------
export FZF_DEFAULT_OPTS="
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

## ----------------------------
## Fix LS_COLORS Being Unreadable
## ----------------------------
export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"

## ----------------------------
## Dotfiles Variable
## ----------------------------
export DOTFILES=$HOME/dotfiles

## ----------------------------
## Default Pictures Directory
## ----------------------------
export XDG_PICTURES_DIR=$(xdg-user-dir PICTURES)

## ----------------------------
## Default Screenshots Directory
## ----------------------------
export XDG_SCREENSHOTS_DIR="${XDG_PICTURES_DIR}/Screenshots"

## ----------------------------
## Grimblast Editor
## ----------------------------
export GRIMBLAST_EDITOR=swappy

## ----------------------------
## Zsh Variable
## ----------------------------
export ZSH=$DOTFILES/zsh
