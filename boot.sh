#!/bin/bash

# Set install mode to online since boot.sh is used for curl installations
export TRND_ONLINE_INSTALL=true

# Sub-zero
ansi_art='
 ______   ______     __   __     _____                                         
/\__  _\ /\  == \   /\ "-.\ \   /\  __-.                                       
\/_/\ \/ \ \  __<   \ \ \-.  \  \ \ \/\ \                                      
   \ \_\  \ \_\ \_\  \ \_\\"\_\  \ \____-                                      
    \/_/   \/_/ /_/   \/_/ \/_/   \/____/                                      
'

clear
echo -e "\n$ansi_art\n"

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified, otherwise default to basecamp/trnd
TRND_REPO="${TRND_REPO:-TheRialNiels/dotfiles}"

echo -e "\nCloning TRND from: https://github.com/${TRND_REPO}.git"
rm -rf ~/.local/share/trnd/
git clone "https://github.com/${TRND_REPO}.git" ~/.local/share/trnd >/dev/null

# Use custom branch if instructed, otherwise default to master
TRND_REF="${TRND_REF:-main}"
if [[ $TRND_REF != "main" ]]; then
  echo -e "\e[32mUsing branch: $TRND_REF\e[0m"
  cd ~/.local/share/trnd
  git fetch origin "${TRND_REF}" && git checkout "${TRND_REF}"
  cd -
fi

# Set edge mirror for dev installs
if [[ $TRND_REF == "dev" ]]; then
  export TRND_MIRROR=edge
else
  export TRND_MIRROR=stable
fi

echo -e "\nInstallation starting..."
source ~/.local/share/trnd/install.sh
