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

# Make array of characters in filename strings
BASE_FILENAME_ARR=($(echo $BASE_FILENAME | grep -o .))
REFERENCE_FILENAME_ARR=($(echo $REFERENCE_FILENAME | grep -o .))

# This is where we will construct the prefix
PREFIX_TO_REMOVE=$@

# Loop through base filename array
for i in $(seq 0 ${#BASE_FILENAME_ARR[@]}); do
	# If the spot in the arrays match, then add to target prefix
	if [[ ${BASE_FILENAME_ARR[i]} == ${REFERENCE_FILENAME_ARR[i]} ]]; then
		echo ${BASE_FILENAME_ARR[i]} "matches" ${REFERENCE_FILENAME_ARR[i]}
		PREFIX_TO_REMOVE+=${BASE_FILENAME_ARR[i]}
	# If the letters do not match, finalize the prefix
	else
		echo ${BASE_FILENAME_ARR[i]} "not matching" ${REFERENCE_FILENAME_ARR[i]}
		echo ${PREFIX_TO_REMOVE[@]}
	fi
done
