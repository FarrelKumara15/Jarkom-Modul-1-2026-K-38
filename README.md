# Jarkom-Modul-1-2026-K-38

### Anggota :
|Nama|NRP|
|---|---|
|Farrel Arteya Kumara | 5027251020|
|Nayla Arsha Adyuta | 5027251042|
 
<br/>

##### No. 11
Buktikan kelemahan protokol Telnet dengan membuat akun phantom_user dan password wired_ghost pada layanan telnetd di node Chisa. Lakukan login Telnet dari node Eiri ke node Chisa dan tangkap sesi menggunakan Wireshark. Tunjukkan kredensial plain text melalui fitur Follow TCP Stream, serta jelaskan mengapa setiap karakter terkirim dalam paket TCP terpisah. <br/><br/>

Menambahkan user phantom user di node chisa <br/>
<img width="503" height="105" alt="Screenshot 2026-09-16 094628" src="https://github.com/user-attachments/assets/bbc61319-3678-4fa9-9f64-cac5d29d4eac" /><br/>
Setup telnet <br/>
<img width="612" height="250" alt="Screenshot 2026-09-16 094745" src="https://github.com/user-attachments/assets/b5bd0d19-c99e-400a-a638-0b7a9fbd7690" /><br/>
Menjalankan telnet di node <br/>
<img width="625" height="460" alt="Screenshot 2026-09-16 094831" src="https://github.com/user-attachments/assets/5da571af-f799-468b-9fd9-85a3cf0b0e15" /><br/><br/>

Kredensial Plain Text: <br/>

```bash
chisa login: 
p
p
han
han
t
t
o
o
m
m
_
_
u
u
s
s
e
e
r
r



Password: 
wired_ghost
```

Karakter yang terkirim dalam paket TCP terpisah karena sesi konsol jarak jauh (seperti Telnet atau SSH) beroperasi dalam Character Mode (Mode Karakter) atau mode interaktif. <br/><br/>

#### No 12
Alice mencurigai Knights menjalankan beberapa layanan rahasia di node-nya. Lakukan pemindaian port dari node Alice ke node Knights menggunakan Netcat (nc) untuk memeriksa port 22 (SSH) dan 80 (HTTP) dalam keadaan terbuka, serta port rahasia 7777 dalam keadaan tertutup. Analisis di Wireshark perbedaan TCP Flag yang dikembalikan antara port terbuka (SYN-ACK) dengan port tertutup (RST-ACK).<br/><br/>

Menyalakan port 22 dan 80 di node knights <br/>
<img width="262" height="45" alt="1  Menyalakan port 22" src="https://github.com/user-attachments/assets/28e0361e-bc37-4d45-aef7-5b8e187d8200" /><br/>
<img width="265" height="42" alt="2  Menyalakan port 80" src="https://github.com/user-attachments/assets/4a173950-ac2e-4bd0-8703-ac776cdd4aaa" /><br/><br/>

Cek IP node knights menggunakan, <br/>
```bash
ip a
```

Scanning port 22, 80, & 7777 node knights di node alice, buka wireshark sebelum scanning<br/>
<img width="694" height="119" alt="Scanning port di alice" src="https://github.com/user-attachments/assets/b7934024-24b6-47e4-ae0f-e161ae277659" /><br/><br/>

Hasil scan port <br/>
<img width="1692" height="62" alt="port 22" src="https://github.com/user-attachments/assets/e32e7601-0ed3-4022-bdfd-9c7f96565bcd" /><br/>
<img width="1697" height="57" alt="port 80" src="https://github.com/user-attachments/assets/7a4447d3-bb20-481b-a8eb-975f6508ca5b" /><br/>
<img width="1572" height="37" alt="port 7777" src="https://github.com/user-attachments/assets/72e15de2-cb5c-448f-a9d8-908389cce29c" /><br/><br/>

|Port|Status|Paket 1 (Alice->Knights)|Paket 2 (Alice->Knights)|Lanjut|
|---|---|---|---|---|
|22|Open|SYN|SYN,ACK|Ya|
|80|Open|SYN|SYN,ACK|Ya|
7777|Closed|SYN|RST,ACK|Tidak|

<br/><br/>
#### No 13
Lain memerintahkan agar administrasi jarak jauh menggunakan SSH
secara aman tanpa password. Install OpenSSH server pada node Knights, buat pasangan kunci SSH (ssh-keygen) pada node Mika untuk user mika_admin, dan konfigurasikan public key authentication (PasswordAuthentication no). Lakukan koneksi SSH dari node Mika ke node Knights, tangkap sesi menggunakan Wireshark, identifikasi paket Protocol Version Exchange dan Key Exchange, serta jelaskan mengapa kredensial tidak terlihat dalam bentuk teks terbuka seperti pada Telnet.
kredensial tidak terlihat jareba SSH menggunakan enkirpsi berbeda dengan Telnet yang dikirim tanpa enkripsi.<br/><br/>

Setup SSH di node knights<br/>
<img width="800" height="237" alt="1  setup ssh" src="https://github.com/user-attachments/assets/438cc2c0-7ac9-4056-a3dd-02415787ce81" /><br/>
Generate SSH Key dan cek apakah sudah nyala<br/>
<img width="801" height="201" alt="2  setup ssh" src="https://github.com/user-attachments/assets/8d273af5-1728-42d6-93a4-515c4d1a6fbc" /><br/>
Menambah user<br/>
<img width="477" height="102" alt="3  menambah user" src="https://github.com/user-attachments/assets/82de85e7-13d5-40fe-b3dc-4f7673a1f8b5" /><br/>
Verifikasi user tidak locked<br/>
<img width="477" height="170" alt="4  verifikasi akun tidak locked" src="https://github.com/user-attachments/assets/edd4528b-bee8-4bb1-84ff-8f7dd11ce2e1" /><br/>
Memasang public key<br/>
<img width="477" height="52" alt="5  memasang public key ssh kinghts (1)" src="https://github.com/user-attachments/assets/34b91002-7148-4887-8d6b-938da654159a" /><br/>
<img width="477" height="317" alt="6  menjalankan ssh di mika" src="https://github.com/user-attachments/assets/09046105-47bf-48d6-b932-d0f589c2ccc2" /><br/>
<img width="477" height="150" alt="image" src="https://github.com/user-attachments/assets/ce647e18-dc4e-41e1-ae95-af86b52ad1bc" /><br/>
Masukkan SSH-RSA ke /home/mika_admin/.sshauthorized_keys<br/>
<img width="477" height="150" alt="5  memasang public key ssh knight (2)" src="https://github.com/user-attachments/assets/1e655499-fa42-44f9-9a47-c7161a284627" /><br/>
<img width="477" height="53" alt="5  memasang public key ssh knight (3)" src="https://github.com/user-attachments/assets/f0a41221-cf6c-47cc-a7d4-1772df754b25" /><br/>
Hapus "#" di<br/>
```bash
PubkeyAuthentication yes
PasswordAuthentication no
```

Menjalankan SSHD<br/>
<img width="477" height="150" alt="7  menjalankan sshd" src="https://github.com/user-attachments/assets/bfb58d1a-9e9d-4393-bc3b-290a07bdb122" /><br/>
Buka wireshark untuk menangkap sesi lalu login dari node mika<br/>
<img width="477" height="510" alt="8  menjalankan ssh di mika" src="https://github.com/user-attachments/assets/6b69c6fa-c155-4d48-844e-331c7481727b" /><br/><br/>

<img width="1397" height="642" alt="new keys   encrypted packet" src="https://github.com/user-attachments/assets/f8f1889e-0df7-43f5-a31d-53a36dd028be" /><br/>
Kredensial tidak terlihat jareba SSH menggunakan enkirpsi berbeda dengan Telnet yang dikirim tanpa enkripsi. <br/><br/>

#### No 14
Setelah gagal mengakses FTP, Eiri melancarkan serangan brute-force terhadap form login web Alice. Analisis file capture wired_bruteforce.pcapng untuk mengidentifikasi alamat IP penyerang, target IP beserta port yang diserang, password user lain_admin yang berhasil ditembus, serta web server software dan versi yang dilaporkan pada response header. Validasi temuan kalian pada socket server:
<br/><br/>

Cek traffic HTTP<br/>
<img width="528" height="485" alt="HTTP" src="https://github.com/user-attachments/assets/ddcfd551-6f60-4c3b-a6b6-f88bf78f68ab" /><br/>
Cek percobaan Login dan IP Destination nya 172.26.7.100<br/>
<img width="1120" height="1022" alt="Mencari request login" src="https://github.com/user-attachments/assets/281d1afc-5259-4365-bb21-43467beee718" /><br/>
Cek paket response<br/>
<img width="1120" height="880" alt="image" src="https://github.com/user-attachments/assets/619fee1b-0d52-46a4-af5e-4e93da829b0e" /><br/>




