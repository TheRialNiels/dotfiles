#!/bin/bash

echo -e "${BLUE}"
figlet "Grub"
echo -e "${NOCOLOR}"

git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes || return
sudo ./install.sh -t vimix
