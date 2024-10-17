#!/bin/bash
# ---
# This script automatically downloads and sorts the spotify playlist
# specified by the user.

# Directory Shorthands
VENV="$PWD/venv"
MUSIC_DIR="/home/$USER/Music"

# Checking for Python Virtual Environment
if [[ -d $VENV ]]; then
  echo "Venv found @"
  else
    # Creating PyVenv if doesn't exist
    echo "Creating Venv."
    python3 -m venv venv
    echo "Venv created @"
fi

# Using the PyVenv as a source
source "$VENV/bin/activate"

# TODO: Check installed dependencies and weigh that against what needs to be installed.
# Then, install if needed.

# User Input
echo "Enter URL of Spotify playlist to download:"
read url

spotdl $url

# Script Finished
exit 0
