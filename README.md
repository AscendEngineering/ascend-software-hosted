# ascend-co-hosted
Repository to host Ascend Collision Overwatch

## Updating the Package
The `publish_deb.sh` script automates publishing the Debian package to a Git-hosted APT repository:
- Copies the latest `ascend-co.deb` file into the current repository folder.
- Generates `Packages.gz` metadata for the APT repository.
- Creates `Release.gpg` and `InRelease` files signed with your GPG key.
- Commits and pushes all changes to the Git repository.

## Installation
To install the service:
```bash
# Import the GPG key
curl -s --compressed "https://AscendEngineering.github.io/ascend-software-hosted/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ascend-software-hosted.gpg >/dev/null

# Add the APT source list
sudo curl -s --compressed -o /etc/apt/sources.list.d/ascend-software-hosted.list "https://AscendEngineering.github.io/ascend-software-hosted/ascend-software-hosted.list"

# Update
sudo apt update

# Install 
sudo apt install ascend-co
```

## Update
To update the service to the latest version:
```bash
# Uninstall
sudo apt remove ascend-co

# Update
sudo apt update

# Install 
sudo apt install ascend-co
```

## Uninstall
To uninstall the service completely:
```bash
sudo apt remove ascend-co

sudo rm /etc/apt/sources.list.d/ascend-software-hosted.list

sudo rm /etc/apt/trusted.gpg.d/ascend-software-hosted.gpg
```


