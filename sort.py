# Libraries
from mutagen.mp3 import MP3
from mutagen.id3 import ID3, TPE1, TALB
import os
import shutil
import sys

def sort(unsorted_dir):
    # Sorts each song in 'unsorted_dir'
    # into '~/Music/' based on the artist, then album

    # Directories
    music_dir = os.path.expanduser("~/Music/")

    # Target extension
    target_extension = ".mp3"

    # Loops through directory
    for song in os.listdir(unsorted_dir):
        # Specifying the file extension to avoid errors
        if song.endswith(target_extension):
            # Build the full file path
            audio_source = os.path.join(unsorted_dir, song)
            
            # Load the audio file
            audio = MP3(audio_source, ID3=ID3)
            
            # Extract the artist and album
            artist = audio.tags.get("TPE1")
            album = audio.tags.get("TALB")
            
            # Check if artist and album exist
            if artist:
                artist_name = artist.text[0]
                print(f"Artist: {artist_name}")
                
                # Create a directory for the artist if it doesn't exist
                artist_dir = os.path.join(music_dir, artist_name)
                if not os.path.exists(artist_dir):
                    os.makedirs(artist_dir)
            
            if album:
                album_name = album.text[0]
                print(f"Album: {album_name}")
                
                # Create album directory inside the artist directory
                album_dir = os.path.join(artist_dir, album_name)
                if not os.path.exists(album_dir):
                    os.makedirs(album_dir)
                
                # Move the file to the artist/album directory
                song_final_destination = os.path.join(album_dir, song)
                shutil.move(audio_source, song_final_destination)
                print(f"Moved: {song} to {song_final_destination}")
            else: 
                print("Unknown album for song:", song)

    print("Done sorting.")

if __name__ == "__main__":
    script_input = sys.argv[1]
    sort(script_input)
