#!/bin/bash
set -e

# Setup structure for a standard APT repo
DEB_DIR="_site/deb"
POOL="$DEB_DIR/pool/main"
DIST_DIR="$DEB_DIR/dists/stable/main/binary-amd64"

mkdir -p "$POOL" "$DIST_DIR"

# 1. Grab all .debs in the root (pushed there by your Foundry)
cp *.deb "$POOL/" 2>/dev/null || true

# 2. Create the Packages index
cd "$DEB_DIR"
dpkg-scanpackages --multiversion pool/main > "$DIST_DIR/Packages"
gzip -9c "$DIST_DIR/Packages" > "$DIST_DIR/Packages.gz"

# 3. Create the Release metadata
cd "dists/stable"
{
  echo "Origin: $ORIGIN"
  echo "Label: Chimera-Optimized"
  echo "Suite: stable"
  echo "Codename: stable"
  echo "Architectures: amd64"
  echo "Components: main"
  echo "Description: Performance Optimized via AutoFDO"
  echo "Date: $(date -Ru)"
} > Release

# 4. Sign the Release file using the key imported by the YML workflow
gpg --batch --yes --clearsign --local-user "$GPG_FINGERPRINT" -o InRelease Release
gpg --batch --yes --detach-sign --local-user "$GPG_FINGERPRINT" -o Release.gpg Release

echo "✅ Apothecary: Repository indexed and signed."
