#!/bin/bash

set -e

echo "=== Installing Kubernetes tools ==="

# Core Kubernetes tools
yay -S --noconfirm --needed kubectl
yay -S --noconfirm --needed k3sup-bin
yay -S --noconfirm --needed helm
yay -S --noconfirm --needed k9s

# Check if k3s is already installed
if command -v k3s &>/dev/null; then
  echo "k3s is already installed ($(k3s --version | head -1))"
else
  echo "Installing k3s..."
  curl -sfL https://get.k3s.io | sh -s - >/dev/null 2>&1 || {
    echo "Failed to install k3s. Run with verbose output:"
    echo "  curl -sfL https://get.k3s.io | sh -"
    exit 1
  }
  echo "k3s installed successfully"
fi
