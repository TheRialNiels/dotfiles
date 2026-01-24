# Install all base packages
mapfile -t packages < <(grep -v '^#' "$TRND_INSTALL/trnd-base.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
