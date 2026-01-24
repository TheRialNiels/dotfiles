if [[ -n ${TRND_ONLINE_INSTALL:-} ]]; then
  # Install build tools
  sudo pacman -S --needed --noconfirm base-devel

  # Configure pacman
  if [[ ${TRND_MIRROR:-} == "edge" ]] ; then
    sudo cp -f ~/.local/share/trnd/default/pacman/pacman-edge.conf /etc/pacman.conf
  else
    sudo cp -f ~/.local/share/trnd/default/pacman/pacman-stable.conf /etc/pacman.conf
  fi

  sudo pacman -Sy


  # Refresh all repos
  sudo pacman -Syyu --noconfirm
fi
