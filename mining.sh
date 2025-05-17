#!/bin/bash

# Konfigurasi mining ke xmrig-proxy lokal
POOL="127.0.0.1:1230"  # Jangan ke IP pool langsung!
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
    echo "▶️ Memulai sesi ke-$i"

    # Jalankan mining via screen
    screen -dmS github ./xmrig -o $POOL -u $WALLET -p $WORKER -t $CPU_THREADS

    echo "⛏️ Menambang selama $DURATION detik..."
    sleep $DURATION

    echo "🛑 Menghentikan sesi ke-$i"
    pkill xmrig

    # Tunggu sebelum sesi berikutnya
    if [ $i -lt 4 ]; then
        echo "⏸️ Jeda selama $PAUSE detik..."
        sleep $PAUSE
    fi
done

echo "✅ Semua sesi mining selesai."
