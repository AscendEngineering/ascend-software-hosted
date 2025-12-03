#!/bin/bash
set -e

echo "Building package..."

EMAIL="apoorv@ascendengineer.com"
ORIG_DIR="$(pwd)"
ASCEND_CO_DIR="$HOME/ascend-co"

cd "$ASCEND_CO_DIR"
# ./build_deb.sh

DEB_FILE=$(ls "$ASCEND_CO_DIR"/*.deb | sort -r | head -n 1)
echo "Found: $DEB_FILE"

cd "$ORIG_DIR"
cp "$DEB_FILE" .

echo "Updating package index..."
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

echo "Signing..."
apt-ftparchive release . > Release
gpg --yes --default-key "$EMAIL" -abs -o Release.gpg Release
gpg --yes --default-key "$EMAIL" --clearsign -o InRelease Release

# echo "Pushing..."
# git add .
# git commit -m "add fixes"
# git push -u origin main

echo "Done."
