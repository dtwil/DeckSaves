# DeckSaves
DeckSaves is a bash script designed to back up your Steam Deck save data to your favorite cloud storage service. It's mainly meant for non-Steam games and games not compatible with Steam Cloud.

## Installation
To install DeckSaves, clone this repository and run `install.sh`. After installation, you'll be prompted to configure rclone to work with your cloud storage service of choice. However, note that your remote config must be named `DeckSaves` in order for this script to work. Once you've configured rclone, you can run `decksaves.sh` to zip and upload your saves. I recommend adding `decksaves.sh` as a non-Steam game so you can run it without having to enter desktop mode.

## Usage
To add a new save folder to DeckSave, run `add_saves.sh` and provide a name along with the save folder path in the prompt that appears. The name can be anything you like, but I recommend choosing a name that helps you remember which save this is (e.g. EmuDeck for your emulator save collection). Once you've added some paths, all the data in them will be zipped and copied to the cloud when you run `decksaves.sh`.

## Why? Program `foo` already does this!
There are a couple of alternatives for backing up save data on your Steam Deck, but at the time of writing this, I couldn't find one that would back up my saves to the cloud for free and without needing to enter desktop mode or have another device running.

## How does it work?
Running `add_saves.sh` creates a symbolic link in the `saves` folder to the folder you provide. Then, when you run `decksaves.sh`, the `saves` folder is zipped and its data is copied to the cloud. Note that the generated zip file includes the actual saves, not the symbolic link files.
