#!/bin/sh

# Tailscale updater for GL.iNet (aarch64)

ARCH="arm64"
URL="https://pkgs.tailscale.com/stable/tailscale_latest_${ARCH}.tgz"

stop_tailscale() {
    if [ -f "/usr/bin/gl_tailscale" ]; then
        /usr/bin/gl_tailscale stop
    else
        /etc/init.d/tailscale stop
    fi
}

start_tailscale() {
    if [ -f "/usr/bin/gl_tailscale" ]; then
        /usr/bin/gl_tailscale restart
    else
        /etc/init.d/tailscale start
    fi
}

echo "Stopping Tailscale..."
stop_tailscale

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
start_tailscale

echo "Done! Version:"
tailscale version
