#!/bin/bash
DOWNLOAD_LINK="https://downloads.rclone.org/rclone-current-linux-amd64.zip"
WELCOME_MSG="Welcome to DeckSaves!\n\nDeckSaves will be installed to this directory."
SUCCESS_MSG="Install complete!\n\nAdd folders by running add_saves.sh, and back them up by running decksaves.sh."

# Display welcome message
zenity --info \
    --text="$WELCOME_MSG" \
    --width=250

# Download rclone
if [ $? -eq 0 ]; then
    curl -o rclone.zip $DOWNLOAD_LINK
else
    zenity --error \
        --text="DeckSave was not installed." \
        --width=250
    exit 1
fi

# Unzip rclone
if [ $? -eq 0 ]; then
    unzip -j -o rclone.zip -d rclone/
else
    zenity --error \
        --text="Downloading rclone failed." \
        --width=250
    exit 1
fi

# Remove the rclone installer and make saves folder
if [ $? -eq 0 ]; then
    rm rclone.zip
    mkdir saves
fi

# Create config file
touch decksaves.config
echo "#!/bin/bash" >> decksaves.config
echo "rclone_path=/rclone/rclone" >> decksaves.config
echo "remote_name=DeckSaves" >> decksaves.config
echo "remote_path=DeckSaves" >> decksaves.config
chmod +x decksaves.config

# Create rclone config
. decksaves.config
timeout 1m .$rclone_path config create $remote_name drive

# Show success dialog
if [ $? -eq 0 ]; then
    zenity --info \
        --text="$SUCCESS_MSG" \
        --width=250
else
    zenity --error \
        --text="DeckSave did not finish setup. Try running the installer again." \
        --width=250
fi