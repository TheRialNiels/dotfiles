#!/bin/bash

# Ensure Walker service is started automatically on boot
mkdir -p ~/.config/autostart/
cp $TRND_PATH/default/walker/walker.desktop ~/.config/autostart/

# Create pacman hook to restart walker after updates
sudo mkdir -p /etc/pacman.d/hooks
sudo tee /etc/pacman.d/hooks/walker-restart.hook > /dev/null << EOF
[Trigger]
Type = Package
Operation = Upgrade
Target = walker
Target = walker-debug
Target = elephant*

[Action]
Description = Restarting Walker services after system update
When = PostTransaction
Exec = $TRND_PATH/bin/trnd-restart-walker
EOF

# Link the visual theme menu config
mkdir -p ~/.config/elephant/menus
ln -snf $TRND_PATH/default/elephant/trnd_themes.lua ~/.config/elephant/menus/trnd_themes.lua
