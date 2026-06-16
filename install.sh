#!/bin/sh
# External Ammyy Installer for Alpine Linux

# Determine the directory where this script is located
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
ARCHIVE_NAME="ammyy_bundle.tar.gz"
ARCHIVE_PATH="${SCRIPT_DIR}/${ARCHIVE_NAME}"

echo "[+] Installing system dependencies..."
apk add --no-cache psmisc sed gawk

echo "[+] Checking for archive file..."
if [ ! -f "$ARCHIVE_PATH" ]; then
    eerror "Required archive not found: ${ARCHIVE_PATH}"
    exit 1
fi

echo "[+] Extracting application files to /opt..."
mkdir -p /opt
tar -xzf "$ARCHIVE_PATH" -C /opt

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

