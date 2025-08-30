#!/bin/bash

# Set default XCompose that is triggered with CapsLock
tee ~/.XCompose >/dev/null <<EOF
include "%H/.local/share/osvmarchi/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$OSVMARCHI_USER_NAME"
<Multi_key> <space> <e> : "$OSVMARCHI_USER_EMAIL"
EOF
