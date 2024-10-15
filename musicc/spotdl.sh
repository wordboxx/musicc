#!/bin/bash

# SCRIPT FOR SHORTCUT TO START SPOTDL
SPOTDL_DIR="/home/$USER/Documents/Projects/musicc"
echo "Moving to $SPOTDL_DIR"
cd $SPOTDL_DIR

# check if virtual environment exists
if [[ ! -d "venv" ]];
    then
        echo "Creating venv..."
        python3 -m venv venv
        echo "venv created."
    else
        echo "venv found."
fi

# activate the virtual environment
source venv/bin/activate
echo "venv activated at $(which pip)"

# get the Spotify URL from user
echo "Enter Spotify URL (or 'sort' to skip to sort): "
read URL

if [[ $URL != "sort" ]];
    then
        # download the song/playlist
        spotdl $URL

        # wait until the download is complete
        echo "Download complete."
    else
        echo "Skipping to sort."
fi

# sort the files, move them to the respective folders
python3 sort.py $SPOTDL_DIR

# deactivate the virtual environment
deactivate

# exit the script
exit 0
