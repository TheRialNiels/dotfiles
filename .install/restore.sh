# ------------------------------------------------------
# Restore
# ------------------------------------------------------

restorelist=""
selectedlist=""
monitorrestored=0

_showRestoreOptions() {
    echo "The following configurations can be transferred into the new installation."
    echo "(SPACE = select/unselect a profile. RETURN = confirm. No selection = CANCEL)"
    echo ""
    
    restorelist=""
    
    if [ -f ~/dotfiles/.bashrc ]; then
        restorelist+="~/dotfiles/.bashrc "
        selectedlist+="~/dotfiles/.bashrc,"
    fi

    if [ -f ~/dotfiles/.zshrc ]; then
        restorelist+="~/dotfiles/.zshrc "
        selectedlist+="~/dotfiles/.zshrc,"
    fi
    
    if [ -d ~/dotfiles/.settings ]; then
        restorelist+="~/dotfiles/.settings "
        selectedlist+="~/dotfiles/.settings,"
    fi
    
    if [ -f ~/dotfiles/hypr/hypridle.conf ]; then
        restorelist+="~/dotfiles/hypr/hypridle.conf "
        selectedlist+="~/dotfiles/hypr/hypridle.conf,"
    fi
    
    if [ -f ~/dotfiles/hypr/conf/custom.conf ]; then
        restorelist+="~/dotfiles/hypr/conf/custom.conf "
        selectedlist+="~/dotfiles/hypr/conf/custom.conf,"
    fi
    
    if [ -f ~/dotfiles/hypr/conf/keyboard.conf ]; then
        restorelist+="~/dotfiles/hypr/conf/keyboard.conf "
        selectedlist+="~/dotfiles/hypr/conf/keyboard.conf,"
    fi

    if [ -f ~/dotfiles/hypr/conf/keybinding.conf ] && [ -d ~/dotfiles/hypr/conf/keybindings/ ]; then
        restorelist+="~/dotfiles/hypr/conf/keybinding.conf "
        selectedlist+="~/dotfiles/hypr/conf/keybinding.conf,"
    fi

    if [ -f ~/dotfiles/hypr/conf/environment.conf ] && [ -d ~/dotfiles/hypr/conf/environments/ ]; then
        restorelist+="~/dotfiles/hypr/conf/environment.conf "
        selectedlist+="~/dotfiles/hypr/conf/environment.conf,"
    fi

    if [ -f ~/dotfiles/hypr/conf/windowrule.conf ] && [ -d ~/dotfiles/hypr/conf/windowrules/ ]; then
        restorelist+="~/dotfiles/hypr/conf/windowrule.conf "
        selectedlist+="~/dotfiles/hypr/conf/windowrule.conf,"
    fi

    if [ -f ~/dotfiles/hypr/conf/monitor.conf ] && [ -d ~/dotfiles/hypr/conf/monitors/ ]; then
        restorelist+="~/dotfiles/hypr/conf/monitor.conf "
        selectedlist+="~/dotfiles/hypr/conf/monitor.conf,"
    fi

    if [ -f ~/dotfiles/hypr/conf/animation.conf ] && [ -d ~/dotfiles/hypr/conf/animations/ ]; then
        restorelist+="~/dotfiles/hypr/conf/animation.conf "
        selectedlist+="~/dotfiles/hypr/conf/animation.conf,"
    fi

    if [ -f ~/dotfiles/hypr/conf/decoration.conf ] && [ -d ~/dotfiles/hypr/conf/decorations/ ]; then
        restorelist+="~/dotfiles/hypr/conf/decoration.conf "
        selectedlist+="~/dotfiles/hypr/conf/decoration.conf,"
    fi

    if [ -f ~/dotfiles/hypr/conf/window.conf ] && [ -d ~/dotfiles/hypr/conf/windows/ ]; then
        restorelist+="~/dotfiles/hypr/conf/window.conf "
        selectedlist+="~/dotfiles/hypr/conf/window.conf,"
    fi
    
    restoreselect=$(gum choose --no-limit --height 20 --cursor-prefix "( ) " --selected-prefix "(x) " --unselected-prefix "( ) " --selected="$selectedlist" $restorelist)
    if [ ! -z "$restoreselect" ] ;then
        echo "Selected to restore:" 
        echo "$restoreselect"
        echo ""
        confirmrestore=$(gum choose "Start restore" "Change restore" "Cancel restore")
        if [ "$confirmrestore" == "Start restore" ] ;then
            _startRestore
        elif [ "$confirmrestore" == "Change restore" ]; then 
            _showRestoreOptions
        else
            echo "Restore skipped."
            return 0
        fi
    else
        echo "No files selected to restore."
        confirmrestore=$(gum choose "Change restore" "Cancel restore")
        if [ -z "${confirmrestore}" ] ;then
            echo "Installation canceled."
            exit
        fi
        if [ "$confirmrestore" == "Change restore" ]; then 
            echo ""
            _showRestoreOptions
        else
            echo "Restore skipped."
            return 0
        fi
    fi
}

_startRestore() {
    if [[ $restoreselect == *"~/dotfiles/.bashrc"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/.bashrc ]; then
            cp ~/dotfiles/.bashrc ~/dotfiles-versions/$version/
            echo ".bashrc restored!"
        fi
    fi
    
    if [[ $restoreselect == *"~/dotfiles/.zshrc"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/.zshrc ]; then
            cp ~/dotfiles/.zshrc ~/dotfiles-versions/$version/
            echo ".zshrc restored!"
        fi
    fi

    if [[ $restoreselect == *"~/dotfiles/.settings"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -d ~/dotfiles/.settings ]; then
            rsync -a -I ~/dotfiles/.settings/ ~/dotfiles-versions/$version/.settings/
            echo ".settings restored!"
        fi
    fi
        
    if [[ $restoreselect == *"~/dotfiles/hypr/hypridle.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/hypridle.conf ]; then
            cp ~/dotfiles/hypr/hypridle.conf ~/dotfiles-versions/$version/hypr/
            echo "Hyprland hypridle.conf restored!"
        fi
    fi
    
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/custom.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/custom.conf ]; then
            cp ~/dotfiles/hypr/conf/custom.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland custom.conf restored!"
        fi
    fi
      
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/keyboard.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/keyboard.conf ]; then
            cp ~/dotfiles/hypr/conf/keyboard.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland keyboard.conf restored!"
        fi
    fi  
        
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/monitor.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/monitor.conf ]; then
            cp ~/dotfiles/hypr/conf/monitor.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland monitor.conf restored!"                
        fi
    fi
      
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/keybinding.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/keybinding.conf ]; then
            cp ~/dotfiles/hypr/conf/keybinding.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland keybinding.conf restored!"
        fi
    fi
      
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/environment.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/environment.conf ]; then
            cp ~/dotfiles/hypr/conf/environment.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland environment.conf restored!"
        fi
    fi    
        
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/windowrule.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/windowrule.conf ]; then
            cp ~/dotfiles/hypr/conf/windowrule.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland windowrule.conf restored!"
        fi
    fi   
       
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/animation.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/animation.conf ]; then
            cp ~/dotfiles/hypr/conf/animation.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland animation.conf restored!"
        fi
    fi
      
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/decoration.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/decoration.conf ]; then
            cp ~/dotfiles/hypr/conf/decoration.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland decoration.conf restored!"
        fi
    fi
      
    if [[ $restoreselect == *"~/dotfiles/hypr/conf/window.conf"* ]] || [[ $restoreselect == *"All"* ]] ; then
        if [ -f ~/dotfiles/hypr/conf/window.conf ]; then
            cp ~/dotfiles/hypr/conf/window.conf ~/dotfiles-versions/$version/hypr/conf/
            echo "Hyprland window.conf restored!"
        fi
    fi
    
    restored=1
    return 0
}

if [ -d ~/dotfiles ]; then
    echo -e "${BLUE}"
    figlet "Restore"
    echo -e "${NOCOLOR}"
    
    restored=0
    echo "The script will try to restore existing configurations."
    echo ""
    
    _showRestoreOptions
fi
