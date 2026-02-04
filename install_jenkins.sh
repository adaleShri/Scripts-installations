#!/usr/bin/env bash
set -e

echo "=== Updating system ==="
sudo apt update

echo "=== Installing Java and fontconfig ==="
sudo apt install -y fontconfig openjdk-21-jre

echo "=== Adding Jenkins key ==="
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2026.key

echo "=== Adding Jenkins repository ==="
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "=== Updating package lists ==="
sudo apt update

echo "=== Installing Jenkins ==="
sudo apt install -y jenkins

echo "=== Starting and enabling Jenkins ==="
sudo systemctl enable --now jenkins

echo "=== Installation complete ==="
echo "Jenkins status:"
sudo systemctl status jenkins --no-pager

echo "=== Your initial Jenkins admin password ==="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo
echo "Open Jenkins at: http://localhost:8080"
