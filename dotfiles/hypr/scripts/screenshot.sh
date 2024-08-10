#!/usr/bin/env bash

# Function to get the current date and time for the filename
timestamp() {
    date +"%Y-%m-%d_%H-%M-%S"
}

# Directory to save the screenshots
SCREENSHOT_DIR="${XDG_SCREENSHOTS_DIR:-$HOME/Pictures/Screenshots}"
mkdir -p "$SCREENSHOT_DIR"

# Function to take a screenshot
takeScreenshot() {
    local mode=$1
    local edit=$2
    local filename="$SCREENSHOT_DIR/screenshot_$(timestamp).png"

    case $mode in
        area)
            grimblast --notify copysave area "$filename"
            ;;
        window)
            grimblast --notify copysave active "$filename"
            ;;
        monitor)
            grimblast --notify copysave output "$filename"
            ;;
        *)
            echo "Invalid mode: $mode"
            exit 1
            ;;
    esac

    if [ "$edit" = true ]; then
        swappy -f "$filename"
    fi
}

# Display options to the user
#echo "Choose an option:"
#echo "a. Capture area"
#echo "w. Capture window"
#echo "f. Capture monitor"
#echo "ae. Capture area and edit with Swappy"
#echo "we. Capture window and edit with Swappy"
#echo "fe. Capture monitor and edit with Swappy"
#read -p "Enter your choice [a|w|f|ae|we|fe]: " choice

choice=$1

# Execute based on user choice
case $choice in
    a)
        takeScreenshot area false
        ;;
    w)
        takeScreenshot window false
        ;;
    f)
        takeScreenshot monitor false
        ;;
    ae)
        takeScreenshot area true
        ;;
    we)
        takeScreenshot window true
        ;;
    fe)
        takeScreenshot monitor true
        ;;
    *)
        echo "Invalid choice: $choice"
        exit 1
        ;;
esac
