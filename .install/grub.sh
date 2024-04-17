#!/usr/bin/env bash

echo -e "${BLUE}"
figlet "Grub"
echo -e "${NOCOLOR}"

cd "$HOME" || return
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes || return
sudo ./install.sh -t vimix
