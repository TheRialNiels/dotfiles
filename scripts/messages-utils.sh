#!/usr/bin/env bash
# -----------------------------------------------------
# Messages Utils
#
# This script contains functions to display messages
# with different colors and styles.
# -----------------------------------------------------

# -----------------------------------------------------
# _message - Displays a message with a specific
# message type. Words inside single quotes will be highlighted in blue.
#
# Usage:
#   _message <type> <message>
#
# Parameters:
#   type: The type of message to display. Valid types are:
#         - success
#         - error
#         - warn
#         - info
#         - important
#   message: The message to display. Words inside single
#            quotes will be highlighted in blue.
#
# Example:
#   _message "success" "This is a 'success' message"
#
# Output:
#   GREEN(::: SUCCESS =>) WHITE(This is a) BLUE(success) WHITE(message)
# -----------------------------------------------------
_message() {
    local type=$1
    local message=$2

    local color
    local prefix

    # Determine the color and prefix based on the message type
    case "$type" in
    success)
        color=$GREEN
        prefix="SUCCESS"
        ;;
    error)
        color=$RED
        prefix="ERROR"
        ;;
    warn)
        color=$YELLOW
        prefix="WARN"
        ;;
    info)
        color=$CYAN
        prefix="INFO"
        ;;
    important)
        color=$ORANGE
        prefix="IMPORTANT"
        ;;
    *)
        _warn "Invalid message type."
        _normal "Valid message types are: success, error, warn, info, important."
        return 1
        ;;
    esac

    # Replace words inside single quotes with the appropriate color
    message=$(echo -e "$message" | sd "'([^']*)'" "${BLUE}\$1${WHITE}")

    # Print the formatted message
    echo -e "\n${color}::: ${prefix} => ${WHITE}${message}${NOCOLOR}\n"
}

# -----------------------------------------------------
# _normal - Displays a normal message.
#
# Usage:
#   _normal <message>
#
# Parameters:
#   message: The normal message to display.
#
# Example:
#   _normal "This is a normal message"
#
# Output:
#   WHITE(::: =>) WHITE(This is a normal message)
# -----------------------------------------------------
_normal() {
    local message=$1
    echo -e "\n${WHITE}::: => ${message}${NOCOLOR}\n"
}

# -----------------------------------------------------
# _whiteText - Displays a white message.
#
# Usage:
#   _whiteText <message>
#
# Parameters:
#   message: The white message to display.
#
# Example:
#   _whiteText "This is a white message"
#
# Output:
#   WHITE(This is a white message)
# -----------------------------------------------------
_whiteText() {
    local message=$1
    echo -e "${WHITE}${message}${NOCOLOR}"
}

# -----------------------------------------------------
# _colorTextTo - Displays a message with a specific color.
#
# Usage:
#   _colorTextTo <color> <message>
#
# Parameters:
#   color: The color to use for the message.
#   message: The message to display.
#
# Example:
#   _colorTextTo "$RED" "This is a red message"
#
# Output:
#   RED(This is a red message)
# -----------------------------------------------------
_colorTextTo() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NOCOLOR}"
}
