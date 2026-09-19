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

Setup SSH<br/>
<img width="800" height="237" alt="1  setup ssh" src="https://github.com/user-attachments/assets/438cc2c0-7ac9-4056-a3dd-02415787ce81" /><br/>
<img width="801" height="201" alt="2  setup ssh" src="https://github.com/user-attachments/assets/8d273af5-1728-42d6-93a4-515c4d1a6fbc" />


