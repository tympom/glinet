#!/bin/sh

# Tailscale updater for GL.iNet (aarch64)

ARCH="arm64"
URL="https://pkgs.tailscale.com/stable/tailscale_latest_${ARCH}.tgz"

echo "Stopping Tailscale..."
/usr/bin/gl_tailscale stop

echo "Downloading Tailscale..."
wget -O /tmp/tailscale.tgz "$URL" || { echo "Download failed!"; exit 1; }

echo "Extracting..."
tar xzf /tmp/tailscale.tgz -C /tmp/ || { echo "Extraction failed!"; exit 1; }

echo "Installing binaries..."
cp /tmp/tailscale_*/tailscale /usr/sbin/tailscale
cp /tmp/tailscale_*/tailscaled /usr/sbin/tailscaled

echo "Cleaning up..."
rm -rf /tmp/tailscale.tgz /tmp/tailscale_*

echo "Starting Tailscale..."
/usr/bin/gl_tailscale start

echo "Done! Version:"
tailscale version
