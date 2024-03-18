# ------------------------------------------------------
# Install .bashrc
# ------------------------------------------------------

echo -e "${BLUE}"
figlet ".zshrc"
echo -e "${NOCOLOR}"

if [ ! -L ~/.zshrc ] && [ -f ~/.zshrc ]; then
    echo "PLEASE NOTE: The script has detected an existing .zshrc file."
fi

if [ -f ~/dotfiles-versions/backups/$datets/.zshrc-old ]; then
    echo "Backup is already available here ~/dotfiles-versions/backups/$datets/.zshrc-old"
fi

if [ ! -L ~/.zshrc ] && [ -f ~/.zshrc ]; then
    zsh_confirm="DO YOU WANT TO REPLACE YOUR EXISTING .zshrc FILE WITH THE DOTFILES .zshrc FILE?"
    if gum confirm "$zsh_confirm" ;then
        rm ~/.zshrc
        _installSymLink .zshrc ~/.zshrc ~/dotfiles/.zshrc ~/.zshrc
    elif [ $? -eq 130 ]; then
            exit 130
    else
        echo "Installation of the .zshrc file skipped."
    fi
else
    zsh_confirm="DO YOU WANT TO INSTALL THE DOTFILES .zshrc FILE NOW?"
    if gum confirm "$zsh_confirm" ;then
        if [ -L ~/.zshrc ] || [ -f ~/.zshrc ]; then
            rm ~/.zshrc
            echo "Existing .zshrc removed."
        fi
        _installSymLink .zshrc ~/.zshrc ~/dotfiles/.zshrc ~/.zshrc
    elif [ $? -eq 130 ]; then
            exit 130
    else
        echo "Installation of the .zshrc file skipped."
    fi
fi

echo -e "\n"

