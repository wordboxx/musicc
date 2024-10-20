#!/bin/bash

# Directory Shorthands
CURR_DIR="$PWD"
VENV="$CURR_DIR/venv"
MUSIC_DIR="/home/$USER/Music"

# ID3v2 Management
# - Extract text from id3v2 debian package manager check.
# - If text does not contain "installed", install.
id3v2_status="$(dpkg -s id3v2 | grep "installed" | cut -b 20-)"
if [[ ! $id3v2_status == "installed" ]]; then
	sudo apt install id3v2
fi

# Python Venv Management
# - If venv doesn't exist, create it.
if [[ ! -d $VENV ]]; then
	echo "Creating Venv."
	python3 -m venv venv
fi

# - Then activate venv.
source "$VENV/bin/activate"
echo "Venv activated @"
echo $VENV

# User Input
# - Menu
echo """
Spotify URL: Will download the song/playlist. (Auto-sort)
YouTube URL: Will download the song/playlist. (Manual sort)
\"sort\"     : Skip downloading, sort existing MP3s with metadata.
"""

# - Get input from user.
read input

# - If user's input contains "spotify," use SpotDL to download.
if [[ $input == *"spotify"* ]]; then
	echo "Downloading from Spotify."
	spotdl $input

# - If user's input contains "youtube," use yt-dlp and
# - direct downloads to "yt-dlp" directory in "Music."
elif [[ $input == *"youtube"* ]]; then
	echo "Downloading from YouTube."

	# - Create "yt-dlp" directory in "Music" if it doesn't exist.
	YT_DLP_DIR="$MUSIC_DIR/yt-dlp"
	if [[ ! -d $YT_DLP_DIR ]]; then
		mkdir "$YT_DLP_DIR"
	fi

	# - Moves to directory so downloads go into it.
	cd $YT_DLP_DIR

	# - Download the song/playlist.
	echo "Downloading yt-dlp."
	yt-dlp --split-chapters -x --audio-format mp3 $input

	#TODO: eliminate redundant prefixes on chapters for easier
	#	   tagging.

	# - Move back to script's directory.
	cd -
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
