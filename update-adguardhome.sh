#!/bin/sh

# AdGuardHome updater for GL.iNet (aarch64)
# Downloads from official Adguard server: static.adguard.com

URL="https://static.adguard.com/adguardhome/release/AdGuardHome_linux_arm64.tar.gz"
TEMP_FILE="/tmp/AdGuardHome.tar.gz"

echo "Downloading AdGuardHome..."
wget -O "$TEMP_FILE" "$URL" || { echo "Download failed!"; exit 1; }

echo "Extracting..."
tar xzf "$TEMP_FILE" -C /tmp/ || { echo "Extraction failed!"; exit 1; }

echo "Installing binary..."
mv /tmp/AdGuardHome/AdGuardHome /usr/bin/AdGuardHome
chmod +x /usr/bin/AdGuardHome

echo "Cleaning up..."
rm -rf "$TEMP_FILE" /tmp/AdGuardHome

echo "Done! Version:"
/usr/bin/AdGuardHome --version
