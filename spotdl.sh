#!/bin/bash

# Directory Shorthands
CURR_DIR="$PWD"
VENV="$CURR_DIR/venv"
MUSIC_DIR="/home/$USER/Music"

# ID3v2 Management
# extract text from id3v2 debian package manager check
id3v2_status="$(dpkg -s id3v2 | grep "installed" | cut -b 20-)"
if [[ ! $id3v2_status == "installed" ]]; then
  sudo apt install id3v2
fi

# Python Venv Management
if [[ ! -d $VENV ]]; then
  echo "Creating Venv."
  python3 -m venv venv
fi

source "$VENV/bin/activate"
echo "Venv activated @"
echo $VENV

# Prompt for User Input
echo """
Spotify URL: Will download the song/playlist. (Metadata auto-sort)
YouTube URL: Will download the song/playlist. (Metadata manual input, auto-sort)
\"sort\"   : Skip downloading; will sort MP3s in this directory with the available metadata.
"""

# TODO: Check if URL has "spotify," "youtube," etc. Use yt-dlp if youtube.
# then prompt user to input metadata. then sort based on that metadata
# --- maybe if video chapters are available, separate into songs?
read url
# TODO: grep URL for matching stuff and make switch-case for options
if [[ $url != "sort" ]]; then
  spotdl $url
fi

# Processing Each Downloaded MP3
for f in *.mp3; do

  # extract artist from ID3v2 output
  artist="$(id3v2 -l "$f" | grep TPE1 | cut -b 38-)"
  artist_dir="$MUSIC_DIR/$artist"

  # make a directory for the artist if it doesn't exist
  if [[ ! -d $artist_dir ]]; then
    mkdir "$artist_dir"
  fi

  # extract album name from ID3v2 output
  album="$(id3v2 -l "$f" | grep TALB | cut -b 32-)"
  album_dir="$artist_dir/$album"

  # make a directory for the album in the artist directory if it doesn't exist
  if [[ ! -d $album_dir ]]; then
    mkdir "$album_dir"
  fi

  # move MP3 to album directory within artist directory
  mv "$f" "$album_dir"
done

# Script Finished
exit 0
