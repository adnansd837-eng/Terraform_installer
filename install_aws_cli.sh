#!/bin/bash

# Exit immediately if any command fails
set -e

echo "====== Starting AWS CLI v2 Installation ======"

# 1. Ensure the script is run with sudo/root privileges
if [ "$EUID" -ne 0 ]; then
  echo "❌ Error: Please run this script with sudo or as root."
  exit 1
fi

# 2. Update package list and install prerequisites
echo "📦 Updating packages and installing prerequisites..."
apt-get update -y && apt-get install -y unzip curl

# 3. Detect system architecture (Intel/AMD vs ARM)
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    URL="https://amazonaws.com"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    URL="https://amazonaws.com"
else
    echo "❌ Error: Unsupported architecture: $ARCH"
    exit 1
fi

# 4. Clean up any previous broken downloads
rm -rf /tmp/awscliv2.zip /tmp/aws

# 5. Download the installation package safely to /tmp
echo "📥 Downloading AWS CLI for $ARCH..."
curl -L "$URL" -o /tmp/awscliv2.zip

# 6. Extract the package
echo "📂 Extracting files..."
unzip -q /tmp/awscliv2.zip -d /tmp

# 7. Run the installer (checks if it's a fresh install or an upgrade)
echo "🚀 Installing AWS CLI..."
if [ -f "/usr/local/bin/aws" ]; then
    /tmp/aws/install --update
else
    /tmp/aws/install
fi

# 8. Cleanup temporary installer files
rm -rf /tmp/awscliv2.zip /tmp/aws

echo "✅ AWS CLI installed successfully!"
aws --version
