#!/bin/sh
# Remote GitHub Ammyy Installer for Alpine Linux

# CONFIGURATION: Synced with your official GitHub repository
GH_USER="dioxine"
GH_REPO="ammyy-alpine"
GH_BRANCH="main"

# Direct URL to your release archive on GitHub
ARCHIVE_URL="https://raw.githubusercontent.com/${GH_USER}/${GH_REPO}/${GH_BRANCH}/ammyy_bundle.tar.gz"

echo "[+] Installing system dependencies..."
apk add --no-cache psmisc sed gawk curl

echo "[+] Downloading and extracting application files to /opt..."
mkdir -p /opt

# Download and pipe directly to tar without creating temporary files on disk
curl -fsSL "$ARCHIVE_URL" | tar -xzC /opt

echo "[+] Deploying OpenRC services from archive..."
cp /opt/ammyy/init/ammyy-relay /etc/init.d/
cp /opt/ammyy/init/ammyy-router /etc/init.d/
chmod +x /etc/init.d/ammyy-relay
chmod +x /etc/init.d/ammyy-router

echo "[+] Enabling services on boot..."
rc-update add ammyy-router default >/dev/null 2>&1
rc-update add ammyy-relay default >/dev/null 2>&1

echo "[+] Launching services..."
rc-service ammyy-router restart
rc-service ammyy-relay restart

echo "[!] Installation completed successfully!"
exit 0
