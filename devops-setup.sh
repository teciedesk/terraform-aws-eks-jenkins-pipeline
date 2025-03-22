#!/bin/bash

# =========================
# TECIEDEVOPS - Ubuntu 24 DevOps Setup Script
# =========================

echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y gnupg software-properties-common curl unzip apt-transport-https ca-certificates lsb-release gnupg2 git

# === Install Terraform ===
echo "🚀 Installing Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform

# === Install AWS CLI v2 ===
echo "🌩️ Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

# === Install kubectl ===
echo "☸️ Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# === Install Helm ===
echo "📦 Installing Helm..."
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt install -y apt-transport-https
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update && sudo apt install -y helm

# === Install Docker ===
echo "🐳 Installing Docker..."
sudo apt remove docker docker.io containerd runc -y
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# === Final Verification ===
echo "✅ Verifying installations..."
terraform -version
aws --version
kubectl version --client
helm version
docker --version
git --version

echo "🔥 All DevOps tools installed successfully!"
echo "👉 IMPORTANT: Log out and log back in (or reboot) for Docker group permissions to apply!"
