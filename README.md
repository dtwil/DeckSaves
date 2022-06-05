# DeckSaves
DeckSaves is a bash script designed to back up your Steam Deck save data to Google Drive, Dropbox, Microsoft OneDrive, and pCloud. It's mainly meant for non-Steam games and games not compatible with Steam Cloud.

## Installation
To install DeckSaves, download the latest release and extract it to an empty directory. Click `install.sh` to complete the installation. Then add `decksaves.sh` as a non-Steam game so you can run it without having to enter desktop mode.

## Usage
Running `decksaves.sh` will open a dialog asking whether you want to add a new save folder or back up your existing ones. When you add a new save folder, you provide the path to it and the name you'd like to associate with it (e.g. Emulators for your emulator save collection). Once you've added some paths, all the data in them will be zipped and copied to the cloud when you run `decksaves.sh` and click the option to back up your saves.

## Why? Program `foo` already does this!
There are a couple of alternatives for backing up save data on your Steam Deck, but at the time of writing this, I couldn't find one that would back up my saves to the cloud for free and without needing to enter desktop mode or have another device running.

## How does it work?
Adding a save folder creates a symbolic link to it in the saves directory. Then this directory is zipped and copied to the cloud while ensuring that the contents of the symbolic links are zipped, not the symbolic link files themselves.
