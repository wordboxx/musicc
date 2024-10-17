#!/bin/bash
# ---
# This script automatically downloads and sorts the spotify playlist
# specified by the user.

# Directory Shorthands
VENV="$PWD/venv"
MUSIC_DIR="/home/$USER/Music"

# Checking for Python Virtual Environment
if [[ ! -d $VENV ]]; then
    # Creating PyVenv if doesn't exist
    echo "Creating Venv."
    python3 -m venv venv
fi

# Using the PyVenv as a source
source "$VENV/bin/activate"
echo "Venv activated @"
echo $VENV

# User Input
echo "Enter URL of Spotify playlist to download:"
read url

# Download the songs
spotdl $url

# Identify .mp3 files
for f in ./*.mp3; do
  echo "found $f"
done

# Script Finished
exit 0
