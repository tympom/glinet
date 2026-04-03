#!/bin/sh
2
 
3
# Tailscale updater for GL.iNet (aarch64)
4
 
5
ARCH="arm64"
6
URL="https://pkgs.tailscale.com/stable/tailscale_latest_${ARCH}.tgz"
7
 
8
stop_tailscale() {
9
    if [ -f "/usr/bin/gl_tailscale" ]; then
10
        /usr/bin/gl_tailscale stop
11
    else
12
        /etc/init.d/tailscale stop
13
    fi
14
}
15
 
16
start_tailscale() {
17
    if [ -f "/usr/bin/gl_tailscale" ]; then
18
        /usr/bin/gl_tailscale restart
19
    else
20
        /etc/init.d/tailscale start
21
    fi
22
}
23
 
24
echo "Stopping Tailscale..."
25
stop_tailscale
26
 
27
echo "Downloading Tailscale..."
28
wget -O /tmp/tailscale.tgz "$URL" || { echo "Download failed!"; exit 1; }
29
 
30
echo "Extracting..."
31
tar xzf /tmp/tailscale.tgz -C /tmp/ || { echo "Extraction failed!"; exit 1; }
32
 
33
echo "Installing binaries..."
34
cp /tmp/tailscale_*/tailscale /usr/sbin/tailscale
35
cp /tmp/tailscale_*/tailscaled /usr/sbin/tailscaled
36
 
37
echo "Cleaning up..."
38
rm -rf /tmp/tailscale.tgz /tmp/tailscale_*
39
 
40
echo "Starting Tailscale..."
41
start_tailscale
42
 
43
echo "Done! Version:"
44
tailscale version