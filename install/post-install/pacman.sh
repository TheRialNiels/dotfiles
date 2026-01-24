# Configure pacman

if [[ ${TRND_MIRROR:-} == "edge" ]] ; then
  sudo cp -f ~/.local/share/trnd/default/pacman/pacman-edge.conf /etc/pacman.conf
  sudo cp -f ~/.local/share/trnd/default/pacman/mirrorlist-edge /etc/pacman.d/mirrorlist
else
  sudo cp -f ~/.local/share/trnd/default/pacman/pacman-stable.conf /etc/pacman.conf
  sudo cp -f ~/.local/share/trnd/default/pacman/mirrorlist-stable /etc/pacman.d/mirrorlist
fi
