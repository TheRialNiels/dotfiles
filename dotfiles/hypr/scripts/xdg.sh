#!/usr/bin/env bash

sleep 1

## Kill all possible running xdg-desktop-portals
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gnome
killall -e xdg-desktop-portal-kde
killall -e xdg-desktop-portal-lxqt
killall -e xdg-desktop-portal-wlr
killall -e xdg-desktop-portal-gtk
killall xdg-desktop-portal
sleep 1

## Start xdg-desktop-portal-hyprland
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2

## Start xdg-desktop-portal
/usr/lib/xdg-desktop-portal &
sleep 1
