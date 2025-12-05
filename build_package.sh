#!/bin/bash
set -e

echo "Building package..."

EMAIL="apoorv@ascendengineer.com"

# Get the current directory name
DIR="$(basename "$PWD")"
echo "Current directory: $DIR"

# Set the Github username
GITHUB_USERNAME="AscendEngineering"

# Update APT package index files
echo "Updating package index..."
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Sign the release metadata and sign it
echo "Signing..."
apt-ftparchive release . > Release
gpg --yes --default-key "$EMAIL" -abs -o Release.gpg Release
gpg --yes --default-key "$EMAIL" --clearsign -o InRelease Release

# Create the APT source list file
echo "Updating source list..."
echo "deb [signed-by=/etc/apt/trusted.gpg.d/${DIR}.gpg] https://$GITHUB_USERNAME.github.io/$DIR ./" > ascend-software-hosted.list

# Push changes to GitHub
echo "Pushing to GitHub..."
git add .
git commit -m "add changes"
git push -u origin main

echo "Done."
