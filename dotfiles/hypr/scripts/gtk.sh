#!/usr/bin/env bash

# -----------------------------------------------------
# Update GNOME settings based on GTK configuration
# -----------------------------------------------------

config="$DOTFILES/gtk/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

gnomeSchema="org.gnome.desktop.interface"

# Use rg to extract the values from the config file
gtkTheme=$(rg '^gtk-theme-name' "$config" | sd '.*=\s*' '')
iconTheme=$(rg '^gtk-icon-theme-name' "$config" | sd '.*=\s*' '')
cursorTheme=$(rg '^gtk-cursor-theme-name' "$config" | sd '.*=\s*' '')
cursorSize=$(rg '^gtk-cursor-theme-size' "$config" | sd '.*=\s*' '')
fontName=$(rg '^gtk-font-name' "$config" | sd '.*=\s*' '')

# Print the extracted values
echo "GTK Theme: $gtkTheme"
echo "Icon Theme: $iconTheme"
echo "Cursor Theme: $cursorTheme"
echo "Cursor Size: $cursorSize"
echo "Font Name: $fontName"

# Update GNOME settings using gsettings
gsettings set "$gnomeSchema" gtk-theme "$gtkTheme"
gsettings set "$gnomeSchema" icon-theme "$iconTheme"
gsettings set "$gnomeSchema" cursor-theme "$cursorTheme"
gsettings set "$gnomeSchema" font-name "$fontName"
gsettings set "$gnomeSchema" color-scheme "prefer-dark"

# Update cursor settings for Hypr
hyprCursorConf="$DOTFILES/hypr/config/cursor.conf"
if [ -f "$hyprCursorConf" ]; then
    echo "exec-once = hyprctl setcursor $cursorTheme $cursorSize" > "$hyprCursorConf"
    hyprctl setcursor "$cursorTheme" "$cursorSize"
fi
