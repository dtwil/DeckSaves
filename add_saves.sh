#!/bin/bash
TITLE="DeckSaves"

symlink_from_path () {
    ln -s $2 saves/$1
}

# Get game name and folder from the user
game_data=$(zenity --forms \
    --title="$TITLE" \
    --text="Add your save" \
    --add-entry="Name (e.g. EmuDeck):" \
    --add-entry="Path to save folder:" \
    --width=300)

# Get the game name and path and replace spaces with underscores
if [ $? -eq 0 ]; then
    name=$(echo $game_data | cut -d "|" -f 1)
    name="${name// /_}"
    path=$(echo $game_data | cut -d "|" -f 2)
    echo $path
else
    exit 1
fi

# Check that the given path is a valid folder
if [ ! -d "$path" ]; then
    zenity --error \
        --title="$TITLE" \
        --text="The given path does not exist or is not a folder." \
        --width=250
    exit 1
fi

# Create the symbolic link to the save folder
symlink_from_path $name $path