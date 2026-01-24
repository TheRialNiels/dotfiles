# TODO - Change to stow
# Copy over TRND configs
mkdir -p ~/.config
cp -R ~/.local/share/trnd/config/* ~/.config/

# Use default bashrc from TRND
cp ~/.local/share/trnd/default/bashrc ~/.bashrc
