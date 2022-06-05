#!/bin/bash
TITLE="DeckSaves"
DOWNLOAD_LINK="https://downloads.rclone.org/rclone-current-linux-amd64.zip"
WELCOME_MSG="Welcome to DeckSaves!\n\nDeckSaves will be installed to this directory."
SUCCESS_MSG="Install complete!\n\nRun decksaves.sh to add save folders and back them up."

# Display welcome message
zenity --info \
    --title="$TITLE" \
    --text="$WELCOME_MSG" \
    --width=250

# Download rclone
if [ $? -eq 0 ]; then
    curl -o rclone.zip $DOWNLOAD_LINK
else
    zenity --error \
        --title="$TITLE" \
        --text="DeckSave was not installed." \
        --width=250
    exit 1
fi

# Unzip rclone
if [ $? -eq 0 ]; then
    unzip -j -o rclone.zip -d rclone/
else
    zenity --error \
        --title="$TITLE" \
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

# Ask for cloud storage provider
cloud_storage=$(zenity --list \
    --title="$TITLE" \
    --text="Select your cloud storage provider below:" \
    --column="Provider" \
        "Google Drive" \
        "Dropbox" \
        "Microsoft OneDrive" \
        "pCloud")
cloud_storage=$(case "$cloud_storage" in
    ("Google Drive") echo "drive" ;;
    ("Dropbox") echo "dropbox" ;;
    ("Microsoft OneDrive") echo "onedrive" ;;
    ("pCloud") echo "pcloud" ;;
    esac)
echo "cloud_storage=$cloud_storage" >> decksaves.config
if [ $? -ne 0 ]; then
    zenity --error \
        --title="$TITLE" \
        --text="DeckSave did not finish setup. Try running the installer again." \
        --width=250
    exit 1

# Create rclone config
. decksaves.config
timeout 1m .$rclone_path config create $remote_name $cloud_storage

# Show success dialog
if [ $? -eq 0 ]; then
    zenity --info \
        --title="$TITLE" \
        --text="$SUCCESS_MSG" \
        --width=250
else
    zenity --error \
        --title="$TITLE" \
        --text="DeckSave did not finish setup. Try running the installer again." \
        --width=250
fi