#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define TRND locations
export TRND_PATH="$HOME/.local/share/trnd"
export TRND_INSTALL="$TRND_PATH/install"
export TRND_INSTALL_LOG_FILE="/var/log/trnd-install.log"
export PATH="$TRND_PATH/bin:$PATH"

# Install
source "$TRND_INSTALL/helpers/all.sh"
source "$TRND_INSTALL/preflight/all.sh"
source "$TRND_INSTALL/packaging/all.sh"
source "$TRND_INSTALL/config/all.sh"
source "$TRND_INSTALL/login/all.sh"
source "$TRND_INSTALL/post-install/all.sh"
