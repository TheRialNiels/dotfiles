#!/usr/bin/env bash

if [[ "$force_install" == "1" ]]; then
    _showNormalMsg "Force installation of all packages..."
    _forcePackagesPacman "${packagesPacman[@]}"
    _forcePackagesYay "${packagesYay[@]}"
else
    _showNormalMsg "Install only missing packages..."
    _installPackagesPacman "${packagesPacman[@]}"
    _installPackagesYay "${packagesYay[@]}"
fi

_showSuccessMsg "Packages installed successfully"
