#!/bin/bash
. decksaves.config

zip -r saves.zip saves/
.$rclone_path copy saves.zip remote:$remote_path --progress > log.txt 2>&1
if [ $? -eq 0 ]; then
    zenity --info \
        --text="Successfully backed up saves!" \
        --width=250
else
    zenity --error \
        --text="Failed to back up saves. See log.txt for details." \
        --width=250
fi