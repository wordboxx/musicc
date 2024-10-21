#!/bin/bash

# Arrays
FILES=(*)    # Array of all files in directory
MP3_FILES=() # Empty array to add mp3's

# Loop through array for mp3's
# TODO: change .sh to mp3 for final version
for file in ${FILES[@]}; do
  if [[ $file == *.sh ]]; then
    MP3_FILES+=($file)
  fi
done

# Make arrays of filenames of first two mp3's
BASE_FILENAME=${MP3_FILES[0]}
REFERENCE_FILENAME=${MP3_FILES[1]}

# Make array of characters in filename string
BASE_FILENAME_ARR=($(echo $BASE_FILENAME | grep -o .))
echo ${BASE_FILENAME_ARR[0]}
