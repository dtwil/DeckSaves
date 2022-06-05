#!/bin/bash
TITLE="DeckSaves"

symlink_from_path () {
    ln -s $2 saves/$1
}

# Get game name and folder from the user
game_data=$(zenity --forms \
    --title="$TITLE" \
    --text="Add your save folder" \
    --add-entry="Name (e.g. EmuDeck):" \
    --add-entry="Path to save folder:" \
    --width=300)

# Get the game name and path and replace spaces with underscores
if [ $? -eq 0 ]; then
    name=$(echo $game_data | cut -d "|" -f 1)
    name="${name// /_}"
    path=$(echo $game_data | cut -d "|" -f 2)
else
    exit
fi

# Check that the given path is a valid folder
if [ ! -d "$path" ]; then
    zenity --error \
        --title="$TITLE" \
        --text="The given path does not exist or is not a folder." \
        --width=250
    ./add_saves.sh
    exit
fi

# Create the symbolic link to the save folder
symlink_from_path $name $path
if [ $? -eq 0 ]; then
    zenity --info \
        --title=$TITLE \
        --text="Success!"
        --width=250
    ./decksaves.sh
else
    zenity --error \
        --title=$TITLE \
        --text="Something went wrong. Is there already a save with that name?"
        --width=250
    ./add_saves.sh