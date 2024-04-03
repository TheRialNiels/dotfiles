# ----------------------------------------------
# --- Keybindings ------------------------------
# ----------------------------------------------

## ---- Use emacs keybindings even if our EDITOR is set to vi ------------------------------
bindkey -e

## ---- Prompt navigation ------------------------------
bindkey "^[[H"      beginning-of-line  # Home
bindkey "^[[F"      end-of-line        # End
bindkey "^[[3~"     delete-char        # Supr
bindkey "^[[1;3C"   forward-word       # Alt+ArrowRight
bindkey "^[[1;3D"   backward-word      # Alt+ArrowLeft
bindkey "^L"        forward-word       # Alt+ArrowRight
bindkey "^H"        backward-word      # Alt+ArrowLeft

## ---- zsh-autosuggestions plugin ------------------------------
bindkey '^ ' autosuggest-accept  # Ctrl + Space

## ---- zsh-history-substring-search plugin ------------------------------
bindkey '^[[A'  history-substring-search-up    # Ctrl+ArrUp
bindkey '^[[B'  history-substring-search-down  # Ctrl+ArrDown
bindkey '^J'    history-substring-search-up    # Ctrl+j
bindkey '^K'    history-substring-search-down  # Ctrl+k
