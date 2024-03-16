#!/bin/bash

version='1.0'

# Load some utils that will be used in the scripts
source utils/utils.sh
source utils/colors.sh

# Check if the script is running with sudo privileges
_checkSudo

# Check some packages before begin with the installation
source installation/before_installation.sh

# Start installation
source utils/print-title.sh

