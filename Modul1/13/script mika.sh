#!/bin/sh

# Menyalakan listener TCP di port 22 secara terus-menerus di latar belakang (background task)
nc -lk -p 22 &

# Menyalakan listener TCP di port 80 secara terus-menerus di latar belakang
nc -lk -p 80 &

# Memberikan jeda 1 detik agar proses background sempat berjalan
sleep 1

# Menampilkan daftar port TCP yang sedang aktif (listening) untuk verifikasi
echo "Daftar port yang terbuka di server:"
netstat -tuln | grep -E ":22|:80"