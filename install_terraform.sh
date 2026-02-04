#!/usr/bin/env bash
set -e

echo "=== Adding HashiCorp GPG key ==="
wget -O - https://apt.releases.hashicorp.com/gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "=== Adding HashiCorp repository ==="
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

echo "=== Updating package lists ==="
sudo apt update

echo "=== Installing Terraform ==="
sudo apt install -y terraform

echo "=== Installation complete ==="
terraform -version
