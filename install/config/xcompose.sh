# TODO - Change trigger
# Set default XCompose that is triggered with CapsLock
tee ~/.XCompose >/dev/null <<EOF
include "%H/.local/share/trnd/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$TRND_USER_NAME"
<Multi_key> <space> <e> : "$TRND_USER_EMAIL"
EOF
