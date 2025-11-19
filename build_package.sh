#!/bin/bash
set -e

# Set email for GPG signing
EMAIL="apoorv@ascendengineer.com"

# Save the directory where this script was originally called
ORIG_DIR="$(pwd)"

# Directory where ascend-co lives
ASCEND_CO_DIR="$HOME/ascend-co"

# Run the build deb script
cd "$ASCEND_CO_DIR"
./build_deb.sh

# Find the built .deb file
DEB_FILE=$(ls $HOME/ascend-co/*.deb | sort -r | head -n 1)

echo "Found package: $DEB_FILE"
# Return to the original directory
cd "$ORIG_DIR"

# Copy the ascend-co_*.deb file into the current folder
cp "$DEB_FILE" .

# Generate Packages and Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Generate Release, Release.gpg, and InRelease
apt-ftparchive release . > Release
gpg --yes --default-key "${EMAIL}" -abs -o Release.gpg Release
gpg --yes --default-key "${EMAIL}" --clearsign -o InRelease Release

# Git operations
git add .
git commit -m "add fixes"
git push -u origin main
