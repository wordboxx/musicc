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
# (to access the SpotDL pip)
echo $VENV
source "$VENV/bin/activate"

# Checking necessary packages
pip freeze -r requirements.txt | echo "SpotDL not installed!"

echo "Install SpotDL? (y/n)"
read input

while [[ $input != [YyNn] ]]
  do
      echo "y/n only, please."
      read input
  done

if [[ $input == [Yy] ]]; then
  pip install spotdl
else
  exit 0
fi

# User Input
echo "Enter URL of Spotify playlist to download:"
read url

spotdl $url

# Sort Downloaded Music
format=*.mp3

# Script Finished
exit 0
