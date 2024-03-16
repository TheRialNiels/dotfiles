#!/bin/bash

# ------------------------------------------------------
# Disable display manager
# ------------------------------------------------------
disman=0

echo -e "${BLUE}"
figlet "Display Manager"
echo -e "${NOCOLOR}"

echo -e "${CYAN}"
echo "IMPORTANT: Starting Hyprland works from tty (terminal) with command Hyprland (recommended)."
echo "or you can try the display manager SDDM (> 0.20.0 already installed) or the latest git version (yay -S sddm)."
echo "Please check: https://wiki.hyprland.org/hyprland-wiki/pages/Getting-Started/Master-Tutorial/#launching-hyprland"
echo "Login with other display managers could fail and could have negative side effects on some devices."
echo "If you have issues with SDDM or other display managers, you can deactivate the display manager"
echo -e "\n"

if [ ! -d ~/dotfiles ];then
    if [ -f /etc/systemd/system/display-manager.service ]; then
        disman=0
	echo -e "${CYAN}"
        echo "You have already installed a display manager on your system."

	echo -e "${BLUE}"
        echo "HOW DO YOU WANT TO PROCEED?"
        dmsel=$(gum choose "Keep current setup" "Deactivate current display manager" "Install sddm")
    else
        disman=1
        echo "There is no display manager installed on your system."
        echo "After the installation/update of the dotfiles, you can start Hyprland with command Hyprland."
	echo -e "${BLUE}"
        echo "HOW DO YOU WANT TO PROCEED?"
        dmsel=$(gum choose "Keep current setup" "Install sddm")
    fi
else
    if [ -f /etc/systemd/system/display-manager.service ]; then
        disman=0
	echo -e "${CYAN}"
        echo "You have already installed a display manager. If your display manager is working fine, you can keep the current setup."
	
	echo -e "${BLUE}"
        echo "HOW DO YOU WANT TO PROCEED?"
        dmsel=$(gum choose "Keep current setup" "Deactivate current display manager" "Install sddm")
    else
        disman=1
	echo -e "${CYAN}"
        echo "There is no display manager installed on your system."
	
	echo -e "${BLUE}"
        echo "HOW DO YOU WANT TO PROCEED?"
        dmsel=$(gum choose "Keep current setup" "Install sddm")
    fi
fi

if [ -z "${dmsel}" ] ;then
    echo -e "${CYAN}"
    echo "Installation canceled."
    echo -e "${NOCOLOR}"
    exit
fi

echo -e "${NOCOLOR}"

if [ "$dmsel" == "Install sddm" ] ;then

    disman=0
    # Try to force the installation of sddm
    echo "Install sddm"
    yay -S --noconfirm sddm sddm-sugar-candy-git --ask 4

    if [ -f /etc/systemd/system/display-manager.service ]; then
        sudo rm /etc/systemd/system/display-manager.service
    fi
    sudo systemctl enable sddm.service

    echo -e "${CYAN}"
    if [ ! -d /etc/sddm.conf.d/ ]; then
        sudo mkdir /etc/sddm.conf.d
        echo "Folder /etc/sddm.conf.d created."
    fi

    sudo cp sddm/sddm.conf /etc/sddm.conf.d/
    echo "File /etc/sddm.conf.d/sddm.conf updated."

    if [ -f /usr/share/sddm/themes/sugar-candy/theme.conf ]; then

        # Cache file for holding the current wallpaper
        sudo cp wallpapers/default.jpg /usr/share/sddm/themes/Backgrounds/current_wallpaper.jpg
        echo "Default wallpaper copied into /usr/share/sddm/themes/Backgrounds/"

        sudo cp sddm/theme.conf /usr/share/sddm/themes/
        sudo sed -i 's/CURRENTWALLPAPER/'"current_wallpaper.jpg"'/' /usr/share/sddm/themes/theme.conf
        echo "File theme.conf updated in /usr/share/sddm/themes/"

    fi

elif [ "$dmsel" == "Deactivate current display manager" ] ;then

    sudo rm /etc/systemd/system/display-manager.service
    echo -e "${CYAN}"
    echo "Current display manager deactivated."
    disman=1

elif [ "$dmsel" == "Keep current setup" ] ;then
    echo -e "${CYAN}"
    echo "Keep current setup."
else
    echo -e "${CYAN}"
    echo "Keep current setup."
fi

echo -e "${NOCOLOR}"

