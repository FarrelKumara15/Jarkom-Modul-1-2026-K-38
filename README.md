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
Klik salah satu paket lalu Follow->HTTP Stream<br/>
```bash
POST /login.php HTTP/1.1
Host: 172.26.7.100:8080
User-Agent: Fuzz Faster U Fool v2.1.0-dev
Content-Type: application/x-www-form-urlencoded
Content-Length: 45

username=lain_admin&password=wired_pr0tocol_7
HTTP/1.1 200 OK
Server: Apache/2.4.62
Content-Type: text/html; charset=UTF-8
Content-Length: 35
X-Powered-By: PHP/8.3.14

<h1>Success! Login successful.</h1>
```

Ip penyerang: 172.26.7.50 <br/>
Ip target: 172.26.7.100 <br/>
Port target:8080 <br/>
Username: lain_admin <br/>
Password: wired_pr0tocol_7 <br/>
Web server: Apache <br/>
Versi apache: 2.4.62 <br/>
PHP: 8.3.14 <br/>

#### Revisi
<img width="923" height="47" alt="image" src="https://github.com/user-attachments/assets/0a7be10e-56fd-4cec-a602-60bb6cc7dbd0" /><br/><br/>

#### No. 15
Eiri menyusup ke ruang server dan memasang perangkat keyboard USB berbahaya pada node Alice. Buka file capture wired_usb_hid.pcap, identifikasi Vendor ID dan Product ID perangkat USB dari deskriptor USB, alamat nomor device USB, serta pesan rahasia yang berhasil dicuri dari keystroke.<br/><br/>

Cari deskriptor device<br/>
<img width="991" height="202" alt="1  Cari deskriptor device" src="https://github.com/user-attachments/assets/4b23d2fd-3b8d-4a8e-a23c-d32b1e4fa909" /><br/>
Klik salah satu packet dan cari USB Device Descriptor<br/>
<img width="682" height="367" alt="2  idVendor idProduct" src="https://github.com/user-attachments/assets/45cce5ac-c578-45ef-aa43-2f1a64cf3aeb" /><br/>
Vendor ID: 0x046D (Logitech, Inc.)<br/>
Product ID: 0xC31C (Keyboard K120)<br/><br/>
Cari alamat nomor device USB<br/>
<img width="1055" height="935" alt="3  Cari alamat no device usb" src="https://github.com/user-attachments/assets/64fe5f86-71fd-4816-9e34-e6a3b8dbeef6" /><br/>
Isolasi traffic interrupt<br/>
<img width="870" height="940" alt="4  Isolasi traffic interrupt" src="https://github.com/user-attachments/assets/6fa4c501-09e0-4344-bf43-0f9b58e3e34a" /><br/>
Ambil payload data<br/>
<img width="870" height="948" alt="5  Ambil payload data" src="https://github.com/user-attachments/assets/5b109f68-8ccc-4dae-82f3-fc320e1991a7" /><br/>
Klik salah satu packet dan lihat<br/>
<img width="908" height="826" alt="6  HID" src="https://github.com/user-attachments/assets/f866586b-2634-4fc4-8701-f4ce5b2e4645" /><br/>
Bisa ditemukan ada pola di Leftover Capture Data<br/><br/>

Buka terminal/vscode di folder tempat file .pcap nya<br/>
Buat decoder menggunakan python<br/>
```bash
PS C:\Users\Farrel\Downloads> & "C:\Program Files\Wireshark\tshark.exe" -r soal15_wired_usb_hid.pcap -Y "usb.capdata" -T fields -e usb.capdata | Out-File -Encoding ASCII hid_data.txt
PS C:\Users\Farrel\Downloads> notepad decode.py
```

buat decode.py <br/>
```bash
keyboard_map = {
    0x04: ('a', 'A'), 0x05: ('b', 'B'), 0x06: ('c', 'C'), 0x07: ('d', 'D'), 0x08: ('e', 'E'),
    0x09: ('f', 'F'), 0x0a: ('g', 'G'), 0x0b: ('h', 'H'), 0x0c: ('i', 'I'), 0x0d: ('j', 'J'),
    0x0e: ('k', 'K'), 0x0f: ('l', 'L'), 0x10: ('m', 'M'), 0x11: ('n', 'N'), 0x12: ('o', 'O'),
    0x13: ('p', 'P'), 0x14: ('q', 'Q'), 0x15: ('r', 'R'), 0x16: ('s', 'S'), 0x17: ('t', 'T'),
    0x18: ('u', 'U'), 0x19: ('v', 'V'), 0x1a: ('w', 'W'), 0x1b: ('x', 'X'), 0x1c: ('y', 'Y'),
    0x1d: ('z', 'Z'), 0x1e: ('1', '!'), 0x1f: ('2', '@'), 0x20: ('3', '#'), 0x21: ('4', '$'),
    0x22: ('5', '%'), 0x23: ('6', '^'), 0x24: ('7', '&'), 0x25: ('8', '*'), 0x26: ('9', '('),
    0x27: ('0', ')'), 0x28: ('\n', '\n'), 0x2a: ('[BACKSPACE]', '[BACKSPACE]'), 0x2b: ('\t', '\t'),
    0x2c: (' ', ' '), 0x2d: ('-', '_'), 0x2e: ('=', '+'), 0x2f: ('[', '{'), 0x30: (']', '}'),
    0x31: ('\\', '|'), 0x33: (';', ':'), 0x34: ('\'', '"'), 0x35: ('`', '~'), 0x36: (',', '<'),
    0x37: ('.', '>'), 0x38: ('/', '?')
}

try:
    with open("hid_data.txt", "r") as f:
        lines = f.readlines()

    output = ""
    for line in lines:
        line = line.strip()
        # Mengabaikan baris kosong atau format yang tidak sesuai
        if not line or len(line) < 16: 
            continue
        
        # Ekstrak Modifier (Byte 1) dan Keycode (Byte 3)
        modifier = int(line[0:2], 16)
        keycode = int(line[4:6], 16)
        
        # Skip jika tidak ada tombol ditekan (00)
        if keycode == 0:
            continue
            
        # Cek apakah Left Shift (02) atau Right Shift (20) sedang ditekan
        is_shift = (modifier == 0x02) or (modifier == 0x20)
        
        if keycode in keyboard_map:
            # Memilih index 0 untuk lowercase, index 1 untuk uppercase
            output += keyboard_map[keycode][1 if is_shift else 0]

    print("\nHasil Decode:\n")
    print(output)
    print("\n")

except FileNotFoundError:
    print("Error: File hid_data.txt tidak ditemukan. Pastikan file ada di folder yang sama.")
```

buka lagi terminal<br/>
<img width="561" height="112" alt="Screenshot 2026-09-19 190809" src="https://github.com/user-attachments/assets/799387f0-7189-4fc6-ad04-ad087ff98d77" /><br/>
Ditemukan pesan rahasianya.<br/>

# Revisi
<img width="927" height="46" alt="image" src="https://github.com/user-attachments/assets/b5c07642-8a56-4ac1-bb36-b47c93205811" /><br/><br/>

#### No 16
Eiri meletakkan file malware di server. Dari file capture wired_ftp_theft.pcap, lakukan analisis lalu lintas FTP untuk mengidentifikasi alamat IP server FTP penyerang, banner software FTP yang digunakan, kredensial login penyerang, serta ukuran (size in bytes) dari file malware knights_payload.exe yang diunduh.<br/><br/>

Isolasi traffic FTP<br/>
<img width="1080" height="440" alt="1  Isolasi semua traffic TFP" src="https://github.com/user-attachments/assets/8b22c5d2-04e1-4164-b625-2cd2e8d9abe6" /><br/>
Buka Statistic->Conversation->TCP<br/>
<img width="1196" height="398" alt="Screenshot 2026-09-19 191521" src="https://github.com/user-attachments/assets/6fb5bdcf-7b67-4d66-803d-bf6917607c30" /><br/>
Mengambil IP yang paling mencurigakan & isolasi berdasarkan IP tersebut<br/>
<img width="1917" height="660" alt="2  Isolasi semua FTP penyerang" src="https://github.com/user-attachments/assets/ad919fa1-b2f7-48e0-a328-3bd5a4f0a08e" /><br/>
Cek banner tiap server
<img width="1220" height="200" alt="3  Banner software FTP" src="https://github.com/user-attachments/assets/600ee46b-7ff5-473e-a21a-f9a94a4e1c25" /><br/>
Mencari kredensial login<br/>
<img width="990" height="237" alt="4  Kredensial login penyerang" src="https://github.com/user-attachments/assets/d3e3a2ec-52c0-448d-ba4c-8bb059d50f47" /><br/>
Mencari nama file yang terlibat<br/>
<img width="1020" height="177" alt="5  Mencari nama file yang terlibat" src="https://github.com/user-attachments/assets/f8af1f5d-0af2-45f3-be1e-9c90b321188a" /><br/>
Mencari ukuran file yang terlibat<br/>
<img width="1517" height="182" alt="6  Ukuran file knights_payload exe (2)" src="https://github.com/user-attachments/assets/6784a020-29b2-4997-a075-6ec5979198f2" /><br/>
IP Penyerang: 198.51.100.7 <br/>
Banner software: vsftpd 3.0.5 <br/>
Kredensial login penyerang: USER: knights_agent & PASS: N4v1_s3cur3_2026 <br/>
Ukuran file: 524288 bytes <br/><br/>

#### Revisi
<img width="927" height="51" alt="image" src="https://github.com/user-attachments/assets/d8036832-0992-4602-88e6-09a6ad857ecb" /><br/><br/>

#### No 17
Alice membuat halaman web di node-nya. Eiri memanfaatkan celah untuk mengunduh payload berbahaya ke sistem Alice. Analisis file capture wired_http_c2.pcap untuk mengidentifikasi nama domain (Host) tempat malware diunduh, alamat IP server penyerang, nama file executable malware yang diunduh, serta kode status HTTP yang dikembalikan. <br/><br/>

Isolasi traffic HTTP<br/>
<img width="970" height="280" alt="1  http" src="https://github.com/user-attachments/assets/4d5227c0-cf65-4f1c-8dcd-48857b40385f" /><br/>
Cari request "GET"<br/>
<img width="985" height="227" alt="2  get http" src="https://github.com/user-attachments/assets/7780f14c-be79-41a3-b4f9-0f5e6dcafa51" /><br/>
Cari header Host di tiap request<br/>
<img width="973" height="227" alt="3  http host" src="https://github.com/user-attachments/assets/afb4665a-1642-473c-b405-839d5ede9f52" /><br/>
Cari request yang mengunduh file .exe<br/>
<img width="972" height="207" alt="4  http contains exe" src="https://github.com/user-attachments/assets/063747ed-c83a-4fd5-b0f4-e3016c18e73b" /><br/>
IP pengirim: 203.0.113.42 <br/>
IP penerima: 10.7.113.42 <br/>
Folder tujuan: /navi_agent.exe <br/>
Kode status: 200 OK <br/><br/>

#### Revisi
<img width="918" height="47" alt="image" src="https://github.com/user-attachments/assets/6aae1bb5-65c8-48d2-b1b6-96863b853ae8" /><br/><br/>

#### No 18
Eiri mengubah taktik penyerangan dengan menanamkan file malware menggunakan protokol file sharing SMB. Analisis file capture wired_smb_transfer.pcapng untuk mengidentifikasi nama protokol jaringan yang dieksploitasi, IP pengirim dan penerima, folder tujuan penyimpanan malware pada sistem korban, serta nama file executable malware yang ditransfer. <br/><br/>

Cek protokol yang dipakai di port 445<br/>
<img width="1336" height="697" alt="1  Cek protokol di port 445" src="https://github.com/user-attachments/assets/a23314e0-0263-4311-8bd4-de1e6efd7fb8" /><br/>
Isolasi traffic protokol SMB2
<img width="1336" height="398" alt="2  Isolasi traffic protokol smb2" src="https://github.com/user-attachments/assets/94b54b64-9ab5-4037-b68b-c89ad29e92be" /><br/>
Cari nama file yang ditransfer<br/>
<img width="1340" height="277" alt="4  Cari nama file yang ditransfer" src="https://github.com/user-attachments/assets/4d6721fc-4651-45aa-abd0-0bd28dd8c878" /><br/>
Protokol Jaringan: SMB2 <br/>
IP pengirim: 10.7.1.100 <br/>
IP penerima: 10.7.1.50 <br/>
Folder tujuan: …\System32\.. <br/>
Nama file executable: wired_trojan_payload.exe <br/><br/>

#### Revisi
<img width="922" height="50" alt="image" src="https://github.com/user-attachments/assets/90822b00-2b39-44ee-95a2-b79ba61b3b04" /><br/<br/>

#### No 19 
Eiri meneror jaringan dengan mengirimkan email pemerasan melalui protokol SMTP tanpa enkripsi. Analisis file capture wired_smtp_threat.pcap pada stream TCP terkait, identifikasi alamat email korban yang ditargetkan, password korban yang diklaim bocor oleh penyerang, jenis malware yang diinfeksikan, batas waktu (dalam hari) yang diberikan, serta MailClientID yang tercantum pada pesan. <br/><br/>

Cek traffic SMTP<br/>
<img width="1492" height="963" alt="Traffic SMTP" src="https://github.com/user-attachments/assets/d28417a5-9712-4f3f-8c10-2e8fb0415666" /><br/>
Buka Statistic->Conversation->TCP<br/>
Mengambil IP yang paling mencurigakan & isolasi berdasarkan IP tersebut<br/>
<img width="1865" height="967" alt="Persempit ke sesi yang mencurigakan" src="https://github.com/user-attachments/assets/3bc718d2-e28b-4fd2-af48-2efe2e545fe2" /><br/>
ip.addr == 185.234.72.19 && ip.addr == 	203.0.113.100 && smtp <br/>
<img width="1247" height="1015" alt="FIlter IP penyerang" src="https://github.com/user-attachments/assets/4eb94ebd-edd2-4dbd-b0c2-2649be650074" /><br/>
Didapatkan:<br/>
Email korban: victim@protocol7.co.jp<br/>
Pass korban: pr0tocol_7_user<br/>
Jenis malware: Ransomware<br/>
Batas waktu: 72 hours (3 dyas)<br/>
MailClientID: 7719980706<br/><br/>

#### Revisi
<img width="920" height="50" alt="image" src="https://github.com/user-attachments/assets/933d3409-45ab-401f-8d84-11c86985fc55" /><br/><br/>

#### No 20
Untuk rencana pamungkasnya, Eiri menyembunyikan komunikasi malware di balik saluran terenkripsi TLS. Namun Alice telah menyediakan file keylog untuk mendekripsi lalu lintas data tersebut. Analisis file capture wired_tls_decrypt.pcapng bersama keyslogfile.txt untuk mengidentifikasi versi protokol TLS yang dinegosiasikan, nama domain (SNI) yang diakses, alamat IP server HTTPS penyerang, User-Agent yang digunakan, serta HTTP request method dan path yang tersembunyi di dalam sesi dekripsi. <br/><br/>


Cari SNI<br/>
<img width="985" height="186" alt="Cari SNI" src="https://github.com/user-attachments/assets/cf15651b-60fb-4c8c-a84d-484eeb91d477" /><br/>
<img width="1133" height="1015" alt="Isolasi paket ClientHello" src="https://github.com/user-attachments/assets/cb5feb7b-857d-414d-b6e1-4b6c8f4c29e8" /><br/>
Isolasi Application Data<br/>
<img width="1182" height="1017" alt="Isolasi Application Data" src="https://github.com/user-attachments/assets/80efb0c7-3f36-42ed-a217-fe8888bc5c45" /><br/>
Cek versi TLS<br/>
<img width="831" height="177" alt="Cek versi TLS" src="https://github.com/user-attachments/assets/574f1d0f-2db2-4991-9810-4fa024c54d7e" /><br/>
Verifikasi Cipher Suite<br/>
<img width="850" height="187" alt="Cipher suite" src="https://github.com/user-attachments/assets/e8bb3cde-0ac2-47da-b21d-6a5986f66fd9" /><br/>
Cek ekstensi ALPN<br/>
<img width="1006" height="207" alt="ALPN" src="https://github.com/user-attachments/assets/66963a9d-2c66-48e4-a800-b8dbc838c945" /><br/>
Isolasi record APplication Data & cek tab Decrypted TLS<br/>
<img width="1182" height="1017" alt="Isolasi Application Data" src="https://github.com/user-attachments/assets/86d845f7-597d-4ae2-b777-7eabab0cd2d6" /><br/>
Isolasi request HTTP<br/>
<img width="1245" height="1011" alt="HTTP Request" src="https://github.com/user-attachments/assets/13e1e583-b5ca-4f65-aeea-b17230993ac3" /><br/><br/>
Didapatkan<br/>
| Temuan | Nilai | Bukti dari Filter |
|---|---|---|
| Versi TLS | TLS 1.2 (0x0303) | Paket #5 |
| SNI/Domain | `example.com` | Paket #2, #4 |
| IP Server | `93.184.216.34` | Paket #8 |
| ALPN | `http/1.1` | Paket #7 |
| HTTP Method | `HEAD` | Paket #10 |
| HTTP Path | `/` | Paket #10 |
| Host Header | `example.com` | Paket #10 |

<br/><br/>
#### Revisi
<img width="920" height="52" alt="image" src="https://github.com/user-attachments/assets/df5b7d34-365e-4712-a2f8-4386d6b5fc13" />
