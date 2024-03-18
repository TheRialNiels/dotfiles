#!/bin/bash
echo -e "${BLUE}"
figlet "GTK"
echo -e "${NOCOLOR}"

# Remove existing symbolic links
gtk_symlink=0
gtk_overwrite=1

if [ -L ~/.config/gtk-3.0 ]; then
  rm ~/.config/gtk-3.0
  gtk_symlink=1
fi

if [ -L ~/.config/gtk-4.0 ]; then
  rm ~/.config/gtk-4.0
  gtk_symlink=1
fi

if [ -L ~/.gtkrc-2.0 ]; then
  rm ~/.gtkrc-2.0
  gtk_symlink=1
fi

if [ -L ~/.Xresources ]; then
  rm ~/.Xresources
  gtk_symlink=1
fi

if [ "$gtk_symlink" == "1" ] ;then
  echo -e "${CYAN}"
  echo ":: Existing symbolic links to GTK configurations removed"
  echo -e "${NOCOLOR}"
fi

if [ -d ~/.config/gtk-3.0 ] ;then
  echo "The script has detected an existing GTK configuration."

  if gum confirm "DO YOU WANT TO OVERWRITE YOUR CONFIGURATION?" ;then
    gtk_overwrite=1
  else
    gtk_overwrite=0
  fi
fi

if [ "$gtk_overwrite" == "1" ] ;then
  cp -r gtk/gtk-3.0 ~/.config/
  cp -r gtk/gtk-4.0 ~/.config/
  cp -r gtk/xsettingsd ~/.config/
  cp gtk/.gtkrc-2.0 ~/
  cp gtk/.Xresources ~/

  echo -e "${GREEN}"
  echo ":: GTK Theme installed"
  echo -e "${NOCOLOR}"
  echo -e "\n"
fi

