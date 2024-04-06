# ------------------------------------------------
# --- Env Variables ------------------------------
# ------------------------------------------------

## ----- Apply same gtk theme to qt apps ------------------------------
export QT_QPA_PLATFORMTHEME='gnome'

## ----- FZF colors ------------------------------
export FZF_DEFAULT_OPTS="
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

## ----- Fix LS_COLORS being unreadable ------------------------------
export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"

## ----- DOTFILES ------------------------------
export DOTFILES=$HOME/dotfiles

## ----- ZSH HOME ------------------------------
export ZSH=$DOTFILES/zsh

## ----- SETTINGS ------------------------------
export SETTINGS_PATH=$DOTFILES/.settings

## ----- BROWSER ------------------------------
export BROWSER=$(cat $SETTINGS_PATH/browser)

## ----- TERMINAL ------------------------------
export TERMINAL=$(cat $SETTINGS_PATH/terminal)

## ----- TERM EDITOR ------------------------------
export TERM_EDITOR=$(cat $SETTINGS_PATH/term-editor)

## ----- EDITOR ------------------------------
export EDITOR=$(cat $SETTINGS_PATH/editor)

## ----- TERM FILE MANAGER ------------------------------
export TERM_FILE_MANAGER=$(cat $SETTINGS_PATH/term-file-manager)

## ----- FILE MANAGER ------------------------------
export FILE_MANAGER=$(cat $SETTINGS_PATH/file-manager)

## ----- NETWORK MANAGER ------------------------------
export NETWORK_MANAGER=$(cat $SETTINGS_PATH/network-manager)

## ----- SOFTWARE MANAGER ------------------------------
export SOFTWARE_MANAGER=$(cat $SETTINGS_PATH/software-manager)

## ----- VOLUME MANAGER ------------------------------
export VOLUME_MANAGER=$(cat $SETTINGS_PATH/volume-manager)

## ----- BLUETOOTH MANAGER ------------------------------
export BLUETOOTH_MANAGER=$(cat $SETTINGS_PATH/bluetooth-manager)
