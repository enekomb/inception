#!/bin/bash
set -e

LOGIN="emunoz"

echo "=== Minimal system bootstrap for Inception ($LOGIN) ==="

# 1. Root check
if [ "$EUID" -ne 0 ]; then
    echo "❌ Run as root"
    exit 1
fi

# 2. Base system
apt update
apt install -y \
    sudo \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    make

# 3. User & sudo
if ! id "$LOGIN" &>/dev/null; then
    echo "❌ User $LOGIN does not exist"
    exit 1
fi

usermod -aG sudo "$LOGIN"

# 4. Docker
if ! command -v docker >/dev/null 2>&1; then
    curl -fsSL https://get.docker.com | sh
fi

# 5. Docker compose plugin
apt install -y docker-compose-plugin

# 6. Docker group
usermod -aG docker "$LOGIN"

echo "✔ Bootstrap finished"
echo "➡ Log out and log back in before running make"
