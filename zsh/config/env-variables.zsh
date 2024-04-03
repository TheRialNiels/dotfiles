# ------------------------------------------------
# --- Env Variables ------------------------------
# ------------------------------------------------

## ----- Apply same gtk theme to qt apps ------------------------------
export QT_QPA_PLATFORMTHEME='gnome'

## ----- FZF colors ------------------------------
export FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
    --color info:7,prompt:2,spinner:1,pointer:232,marker:1
"

## ----- Fix LS_COLORS being unreadable ------------------------------
export LS_COLORS="${LS_COLORS}:su=30;41:ow=30;42:st=30;44:"
