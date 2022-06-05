#!/bin/bash
TITLE="DeckSaves"

symlink_from_path () {
    ln -s $2 saves/$1
}

zenity --question \
    --title="$TITLE" \
    --text="Do you want to add a new save or back up your current saves?" \
    --cancel-label="Add Save" \
    --ok-label="Back Up Saves" \
    --width=250

if [ $? -eq 0 ]; then
    ./upload.sh
else
    ./add_saves.sh
fi