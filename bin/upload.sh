#!/bin/bash
TITLE="DeckSaves"

. decksaves.config
zip -r saves.zip saves/
.$rclone_path copy saves.zip $remote_name:$remote_path --progress > log.txt 2>&1

if [ $? -eq 0 ]; then
    zenity --info \
        --title=$TITLE \
        --text="Successfully backed up saves!" \
        --width=250
else
    zenity --error \
        --title=$TITLE \
        --text="Failed to back up saves. See log.txt for details." \
        --width=250
fi