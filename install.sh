#!/bin/bash

version='1.0'

# Load some utils that will be used in the scripts
source utils/utils.sh
source utils/colors.sh

# Check if the script is running with sudo privileges
#_checkSudo

# Check some packages before begin with the installation
source installation/before_installation.sh

source utils/print-title.sh

source installation/confirm_installation.sh

source installation/yay.sh

source installation/backup.sh

