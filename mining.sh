#!/bin/bash

# Konfigurasi mining ke xmrig-proxy lokal
POOL="127.0.0.1:3333"
WALLET="4jam"          # Ini hanya nama worker di proxy
WORKER="codespace"     # Nama instance, bisa diganti
CPU_THREADS=3
DURATION=3480          # 58 menit
PAUSE=300              # 5 menit

# Pastikan screen terinstal
if ! command -v screen &> /dev/null; then
    echo "screen tidak ditemukan! Instal dengan: sudo apt install screen"
    exit 1
fi

# Cek apakah file xmrig ada
if [ ! -f "./xmrig" ]; then
    echo "XMRig tidak ditemukan! Pastikan file xmrig ada di folder ini."
    exit 1
fi

# Loop untuk 4 sesi mining
for i in {1..4}; do
    SESSION_NAME="mining_sesi_$i"
    echo "▶️ Memulai sesi ke-$i dengan screen session '$SESSION_NAME'"

    # Jalankan mining via screen dengan nama sesi unik
    screen -dmS $SESSION_NAME ./xmrig -o $POOL -u $WALLET -p $WORKER -t $CPU_THREADS

    echo "⛏️ Menambang selama $DURATION detik..."
    sleep $DURATION

    echo "🛑 Menghentikan sesi ke-$i"
    # Berhentiin screen session khusus sesi ini
    screen -S $SESSION_NAME -X quit

    # Tunggu sebelum sesi berikutnya, kecuali sesi terakhir
    if [ $i -lt 4 ]; then
        echo "⏸️ Jeda selama $PAUSE detik..."
        sleep $PAUSE
    fi
done

echo "✅ Semua sesi mining selesai."
