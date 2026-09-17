#!/bin/sh

# 1. Update repositori dan install paket Telnet (mengabaikan busybox_extras yang error)
apk update
apk add inetutils-telnet

# 2. Membuat user phantom_user secara non-interaktif (-D menonaktifkan prompt)
adduser -D phantom_user

# 3. Mengatur password untuk phantom_user tanpa prompt (ganti "rahasia123" sesuai password yang Anda inginkan)
echo "phantom_user:rahasia123" | chpasswd

# 4. Menjalankan layanan Telnet Daemon di latar belakang
telnetd -l /bin/login &

# 5. Memberikan jeda singkat lalu memverifikasi port 23 (Telnet)
sleep 1
echo "Verifikasi port Telnet (23) aktif:"
netstat -tuln | grep 23