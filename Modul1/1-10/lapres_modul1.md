# Jarkom-Modul-1-2026-K-38

**Kelompok** : K-38

**Anggota** :

| Nama                 | NRP        |
| -------------------- | ---------- |
| Farrel Arteya Kumara | 5027251020 |
| Nayla Arsha Adyuta   | 5027251042 |

### Soal 1

Soal 1 minta router Lain membuat tiga Switch/Gateway untuk mempersiapkan pembangunan The Wired: Switch 1 menuju Alice & Mika, Switch 2 menuju Chisa, Switch 3 menuju Knights & Eiri. Kelima Entitas dikonfigurasi sebagai Client di GNS3 memakai prefix IP kelompok (`192.230.x.x`).

Router (Lain) — eth1, eth2, eth3 masing-masing jadi gateway satu switch:

```sh
auto eth1
iface eth1 inet static
address 192.230.1.1
netmask 255.255.255.0

auto eth2
iface eth2 inet static
address 192.230.2.1
netmask 255.255.255.0

auto eth3
iface eth3 inet static
address 192.230.3.1
netmask 255.255.255.0
```

Alice dan Mika (Switch 1):

```sh
# Alice
auto eth0
iface eth0 inet static
address 192.230.1.2
netmask 255.255.255.0
gateway 192.230.1.1

# Mika
auto eth0
iface eth0 inet static
address 192.230.1.3
netmask 255.255.255.0
gateway 192.230.1.1
```

Chisa (Switch 2):

```sh
# Chisa
auto eth0
iface eth0 inet static
address 192.230.2.2
netmask 255.255.255.0
gateway 192.230.2.1
```

Eiri dan Knights (Switch 3):

```sh
# Eiri
auto eth0
iface eth0 inet static
address 192.230.3.2
netmask 255.255.255.0
gateway 192.230.3.1

# Knights
auto eth0
iface eth0 inet static
address 192.230.3.3
netmask 255.255.255.0
gateway 192.230.3.1
```

Setelah konfigurasi dijalankan di tiap node dengan `ifup eth0`/`ifup eth1` dst (atau restart networking), topologi GNS3 menampilkan Lain sebagai router pusat yang terhubung ke tiga switch, dan tiap switch terhubung ke Entitas-Entitas sesuai pembagian di atas.

#### Output

![](image.png)

---

### Soal 2

Soal 2 minta router Lain terhubung ke internet publik lewat NAT/DHCP di interface eth0, karena The Wired pada saat itu masih terisolasi dari dunia luar.

```sh
auto eth0
iface eth0 inet dhcp
```

eth0 dibiarkan mendapat IP otomatis dari DHCP jaringan luar, sehingga router langsung punya akses internet tanpa perlu setting IP manual.

#### Output

![](image-1.png)

---

### Soal 3

Pada soal 3, seluruh Entitas (Client) di bawah Switch 1, Switch 2, dan Switch 3 harus bisa saling terhubung dan berkomunikasi satu sama lain melalui konfigurasi routing.

Karena router Lain terhubung langsung ke ketiga subnet lewat eth1, eth2, dan eth3, routing antar subnet sudah terbentuk otomatis dari routing table router tanpa perlu tambahan konfigurasi khusus. Pembuktiannya dilakukan dengan ping ke IP Address Entitas di subnet lain:

```sh
ping -c 2 <IP_tujuan>
```

#### Output

![](image-2.png)
![](image-3.png)

---

### Soal 4

Pada soal 4, tiap Entitas (Client) diminta punya kemandirian di The Wired, yaitu bisa ping ke 8.8.8.8 dan membuka domain google.com, lewat konfigurasi firewall/iptables NAT Masquerade dan DNS resolver.

Langkah pertama, buat file `router.sh` di router Lain berisi command NAT dan forwarding:

```sh
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth3 -o eth0 -j ACCEPT
```

```sh
chmod +x router.sh
./router.sh
```

`MASQUERADE` di tabel `nat` bertugas nge-rewrite source IP private client (192.230.x.x) menjadi IP publik router saat paket keluar lewat eth0, supaya balasan dari internet bisa kembali ke router dan di-translate ulang ke client yang benar. Tanpa ini, client dengan IP private tidak bisa langsung berkomunikasi dengan server di internet.

`FORWARD` mengatur izin apakah sebuah paket boleh diteruskan dari satu interface ke interface lain di router. Default policy `FORWARD` di banyak sistem adalah `ACCEPT`, makanya soal 3 tadi bisa langsung jalan tanpa rule tambahan. Tapi kalau default policy-nya `DROP`, paket dari client yang mau keluar ke eth0 (internet) akan tertahan di router meskipun NAT-nya sudah benar. Karena itu, tiga baris `ACCEPT` ditambahkan untuk memastikan secara eksplisit trafik dari eth1, eth2, dan eth3 menuju eth0 diizinkan lewat.

Untuk DNS resolver, tiap client diset otomatis saat interface naik, contoh di Eiri:

```sh
auto eth0
iface eth0 inet static
address 192.230.3.2
netmask 255.255.255.0
gateway 192.230.3.1
up echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

`8.8.8.8` adalah alamat Google Public DNS, dipakai supaya client bisa menerjemahkan nama domain (google.com) menjadi IP address. Tanpa ini client hanya bisa akses internet pakai IP langsung, tidak bisa membuka website lewat nama domainnya.

Baris `up echo "nameserver 8.8.8.8" > /etc/resolv.conf` adalah bagian dari `/etc/network/interfaces`, bukan file terpisah. `up` artinya command yang dijalankan otomatis tiap kali interface eth0 naik. Isi command-nya menulis ke `/etc/resolv.conf`, file khusus yang menyimpan daftar DNS server yang dipakai sistem untuk resolve domain (terpisah dari `/etc/network/interfaces` yang isinya konfigurasi IP address dan routing interface). Jadi tidak perlu edit manual `/etc/resolv.conf` di terminal, cukup taruh baris `up echo ...` itu di dalam `/etc/network/interfaces` (edit pakai `nano /etc/network/interfaces`), dan tiap kali eth0 up, `/etc/resolv.conf` otomatis ter-generate ulang. Cara yang sama diterapkan ke Alice, Mika, Chisa, dan Knights.

#### Output

![](image-4.png)

---

### Soal 5

Eiri tetap berupaya menanamkan kekacauan ke dalam jaringan, sehingga untuk mengantisipasi restart tiba-tiba, pada soal 5 diminta membuat script verifikasi `/root/cek_status.sh` di router Lain yang menampilkan ringkasan interface (`ip -br a`) dan status tabel NAT (`iptables -t nat -L -v -n`) setelah reboot.

```sh
nano /root/cek_status.sh
```

Isi `cek_status.sh`:

```sh
#!/bin/bash
ip -br a
iptables -t nat -L -v -n
```

```sh
chmod +x /root/cek_status.sh
```

Script `router.sh` dari soal 4 dan `cek_status.sh` ditaruh di `init.sh` supaya otomatis jalan tiap kali router boot atau di-restart:

```sh
/root/router.sh
/root/cek_status.sh
```

Jadi begitu router Lain nyala ulang, `router.sh` langsung menerapkan ulang aturan NAT dan forwarding, sedangkan `cek_status.sh` langsung menampilkan ringkasan interface dan status tabel NAT untuk memastikan konfigurasi tidak hilang, tanpa perlu dicek manual satu per satu — sehingga upaya Eiri menanamkan kekacauan lewat restart mendadak tidak berhasil mengganggu konfigurasi jaringan.

#### Output

![](image-5.png)

---

### Soal 6

Mika mencurigai adanya anomali traffic pada segmen jaringannya. Pada soal 6 diminta menjalankan traffic generator di node Mika, lalu sniffing pakai Wireshark dengan display filter khusus untuk paket DNS atau ICMP.

File generator diunduh dari link yang diberikan, isinya disalin ke node Mika sebagai `traffic_protocol7.sh`:

```sh
nano traffic_protocol7.sh
```

```sh
#!/bin/bash
# ============================================
# Traffic Generator — Protocol 7 Network
# Serial Experiments Lain — Modul 1 Jarkom 2026
# Jalankan di node MIKA untuk generate traffic DNS & ICMP
# ============================================

echo "============================================"
echo "  Protocol 7 Traffic Generator v2026"
echo "  Node: Mika Iwakura"
echo "============================================"
echo "[*] Generating DNS & ICMP traffic..."

# ICMP Traffic
ping -c 5 8.8.8.8 &
ping -c 5 1.1.1.1 &
ping -c 3 its.ac.id &

# DNS Queries
nslookup google.com 8.8.8.8 &
nslookup its.ac.id 8.8.8.8 &
nslookup github.com 1.1.1.1 &
dig @8.8.8.8 example.com A &
dig @1.1.1.1 cloudflare.com AAAA &

wait
echo "[*] Traffic generation complete."
echo "[*] Check Wireshark for captured packets."
```

```sh
chmod +x traffic_protocol7.sh
```

Script ini generate dua jenis traffic sekaligus secara paralel (pakai `&`): ICMP lewat `ping` ke beberapa target (8.8.8.8, 1.1.1.1, its.ac.id), dan DNS query lewat `nslookup` dan `dig` ke beberapa domain. Baris `wait` di akhir memastikan script menunggu semua proses background selesai dulu sebelum menampilkan pesan selesai.

Sebelum script dijalankan, capture Wireshark di interface node Mika distart dulu, baru script dieksekusi:

```sh
./traffic_protocol7.sh
```

Setelah traffic terekam, di Wireshark diterapkan display filter:

```
dns or icmp
```

Dari hasil filter, terlihat paket-paket DNS query/response ke domain-domain yang di-query dan paket ICMP Echo Request/Reply ke target-target yang di-ping, sesuai skenario anomali traffic yang dicurigai Mika.

#### Output

![](image-6.png)

---

### Soal 7

Chisa memutuskan mendirikan FTP Server pada node miliknya dengan shared folder `/var/wired/data`. Kebijakan aksesnya: user alice (read & write), user mika (dibatasi read-only), user eiri (tanpa izin akses sama sekali / blacklist).

Bikin folder shared dulu:

```sh
mkdir -p /var/wired/data
chown root:root /var/wired/data
```

Bikin 3 user OS yang jadi akun FTP:

```sh
adduser -D alice
adduser -D mika
adduser -D eiri
```

Install tools yang dibutuhkan, termasuk `shadow` supaya `usermod` bisa dipakai:

```sh
apk update
apk add shadow
apk add vsftpd
```

Bikin grup akses khusus, alice dan mika dimasukkan ke grup ini:

```sh
addgroup ftpaccess
adduser alice ftpaccess
adduser mika ftpaccess
```

Arahkan home directory ketiga user ke folder shared:

```sh
usermod -d /var/wired/data alice
usermod -d /var/wired/data mika
usermod -d /var/wired/data eiri
```

```sh
chown root:ftpaccess /var/wired/data
chmod 770 /var/wired/data
```

Whitelist alice dan mika di userlist, otomatis eiri ter-blacklist karena tidak masuk daftar:

```sh
echo -e "alice\nmika" > /etc/vsftpd.userlist
```

Setting read-only khusus buat mika:

```sh
mkdir -p /etc/vsftpd/user_conf
echo "write_enable=NO" > /etc/vsftpd/user_conf/mika
```

Isi `/etc/vsftpd.conf`:

```sh
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_root=/var/wired/data
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
user_config_dir=/etc/vsftpd/user_conf
seccomp_sandbox=NO
pam_service_name=vsftpd
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30100
file_open_mode=0666
local_umask=002
```

Jalankan servernya:

```sh
vsftpd /etc/vsftpd.conf &
```

**Pembuktian read & write alice** — buat file `signal_alice.txt` lalu login FTP pakai akun alice untuk upload:

```sh
nano signal_alice.txt
# isi file
lftp alice@192.230.2.2
put signal_alice.txt
```

**Pembuktian penolakan akses eiri**:

```sh
lftp eiri@192.230.2.2
```

Login eiri gagal karena `eiri` tidak ada di `/etc/vsftpd.userlist` sedangkan `userlist_deny=NO` (artinya hanya user yang ada di file itu yang diizinkan login), sehingga eiri otomatis diblokir tanpa perlu rule tambahan.

Hasil testing pakai lftp menunjukkan user alice bisa melakukan put, get, dan ls karena punya akses penuh, user mika bisa get tapi gagal put karena `write_enable=NO`, sedangkan user eiri gagal login sama sekali sehingga semua command tidak bisa dijalankan.

#### Output

![](image-7.png)

---

### Soal 8

Kelompok rahasia Knights perlu mengirim dokumen laporan intelijen ke FTP Server Chisa. Soal 8 minta Knights melakukan koneksi FTP dari node Knights ke server Chisa memakai akun alice untuk upload dokumen, lalu dianalisis di Wireshark: perintah STOR, status 226, dan port data PASV.

```sh
nano knights_report.txt
# isi file laporan intelijen, copas dari drive
lftp alice@192.230.2.2
put knights_report.txt
```

Analisis dari Follow TCP Stream di Wireshark:

- Login: `USER alice` → `331 Please specify the password.` → `PASS ...` → `230 Login successful.`
- Mode binary: `TYPE I`
- Negosiasi PASV: request `PASV` → response `227 Entering Passive Mode (192,230,2,2,117,57)`, artinya port data = 117×256+57 = **30009** (masuk range `pasv_min_port`-`pasv_max_port` 30000-30100 yang sudah diset di vsftpd.conf)
- Upload: `STOR knights_report.txt` → `226 Transfer complete.`

#### Output

![](image-8.png)

---

### Soal 9

Mika mengakses dokumen Protokol Tujuh dari FTP Server Chisa. Soal 9 minta Mika mendownload `protocol7_manifesto.txt` memakai akun mika, lalu membuktikan pembatasan read-only-nya dengan mencoba upload file baru.

```sh
lftp mika@192.230.2.2
lftp mika@192.230.2.2:~> ls
-rw-rw-r--   1 1000     1000        1111 Sep 15 20:49 knights_report.txt
-rw-r--r--   1 0        0           1738 Sep 15 21:18 protocol7_manifesto.txt
-rw-rw-r--   1 1000     1003          16 Sep 15 20:12 signal_alice.txt
lftp mika@192.230.2.2:~> get protocol7_manifesto.txt
1738 bytes transferred
lftp mika@192.230.2.2:~> put protocol7_manifesto.txt
put: Access failed: 550 Permission denied. (protocol7_manifesto.txt)
```

Terbukti mika bisa `get` file `protocol7_manifesto.txt` dengan sukses, tapi kena `550 Permission denied` saat mencoba `put`, sesuai `write_enable=NO` yang khusus diset untuk user mika di soal 7.

#### Output

![](image-9.png)

---

### Soal 10

Knights melancarkan uji ketahanan koneksi ke server Chisa untuk menguji latensi jaringan The Wired. Soal 10 minta Knights ping ke Chisa dengan payload 128 byte, interval 0.3 detik, sebanyak 77 paket.

```sh
ping -c 77 -s 128 -i 0.3 192.230.2.2
```

Di Wireshark, tiap Echo Request (ICMP Type 8, Code 0) dibalas Echo Reply (ICMP Type 0, Code 0) dengan id dan seq yang sama. TTL request 63 dan reply 64 (berbeda karena melewati hop yang berbeda).

Hasil statistik ping:

- Packets transmitted: 77, received: 77, packet loss: **0%**
- RTT min/avg/max berkisar **0.4–1.06 ms**

Tidak ada packet loss dan RTT stabil, artinya koneksi The Wired antara Knights dan Chisa berjalan lancar tanpa gangguan meski dikirim payload lebih besar dan interval rapat.

#### Output

![](image-10.png)
![](image-11.png)

---

### Kendala saat mengerjakan

- Kesusahan saat mengkonfigurasi nomor 7
- Lupa mencatat dan ss setiap langkah dan soal yang dikerjakan
