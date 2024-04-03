[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/nyzv0V02)
<div align=center>

|    NRP     |      Name      |
| :--------: | :------------: |
| 5025221158 | Muhammad Aqil Farrukh |
| 5025221195 | Ahmad Fadhilah Mappisara |
| 5025221025 | Wahid Badar Abiddin |

# Praktikum Modul 1 _(Module 1 Lab Work)_

</div>

### Daftar Soal _(Task List)_

- [Task 1 - Tim Kawal Bubu _(Bubu's Monitoring Team)_](/task-1/)

- [Task 2 - Gabut Yuan _(Yuan's Boredom)_](/task-2/)

- [Task 3 - Magang Bubu _(Bubu's Internship)_](/task-3/)

- [Task 4 - LDR Isabel _(Isabel Sad Relationship)_](/task-4/)

### Laporan Resmi Praktikum Modul 1 _(Module 1 Lab Work Report)_

Tulis laporan resmi di sini!

_Write your lab work report here!_


# **TASK 1**
# **Dikerjakan Oleh MUHAMMAD AQIL FARRUKH 5025221158**
## Tim Kawal Bubu _(Bubu's Monitoring Team)_

Setelah masa upload proposal PKM 2024, Bubu sebagai sebagai anggota tim kawal melakukan scraping data upload dan mendapat file dalam format comma separated value (.csv). Bubu Pun mengirimkan [file](/resources/data-pkm.csv) tersebut ke komandan PKM, namun komandan memiliki kesulitan untuk membaca data tersebut. Beliau mendelegasikan Bubu untuk menganalisis data tersebut. Karena kamu adalah Suhu dalam perlinux-an menurut Bubu maka ia spontan membuat challenge untukmu mengerjakan task tersebut seluruhnya menggunakan shell scripting. Sebagai teman yang baik kamu pun menerima challenge itu. Adapun analisis yang diminta oleh komandan adalah sebagai berikut:

_After the upload period of the 2024 PKM proposal, Bubu, as a member of the monitoring team, scraped the uploaded data and obtained a file in comma-separated value (.csv) format. Bubu then sent the [file](/resources/data-pkm.csv) to the PKM commander, but the commander had difficulty reading the data. He delegated Bubu to analyse the data. Because you're considered the 'Temperature' in the Linux world according to Bubu, he spontaneously created a challenge for you to complete the task entirely using shell scripting. As a good friend, you accepted the challenge. The analysis requested by the commander is as follows:_

## **SOAL 1A**
- a. Karena Belmawa menetapkan judul maksimum proposal 20 kata, maka komandan ingin mencari data siapa saja tim yang tidak memenuhi ketentuan ini. Tampilkan nama pengusul, beserta departemennya yang judulnya lebih dari 20 kata. Pisahkan spasi dan hapus underscore "\_" pada nama pengusul.

  _a. Because Belmawa sets the maximum proposal title to 20 words, the commander wants to find out which teams do not meet this requirement. Display the names of the proposers along with their departments whose titles are more than 20 words. Separate with spaces and remove underscores "\_" from the proposers' names._

## PENYELESAIAN 1A

  ### Langkah - langkah 
1. Inisialisasi deklarasi path untuk csv file
2. Kemudian membuat perulangan untuk mendapatkan index dari judul, nama pengusul dan departemen di header
3. Setelah mendapatkan index dari masing masing variable, kemudian dilanjutkan mencari baris selanjutnya dimana dilakukan kondisi if jika ternayata ada lebih dari 7 kolom yang mana ini disebabkan oleh judul yang memiliki koma sehingga dianggap kolom setiap ada koma di judul, yang mana ini membuat kolom yang harusnya seperti di header yaitu ada 7 kolom menjadi lebih dari 7 kolom. 
4. Setelah ditemukan baris yang memiliki kolom lebih dari 7 , maka judul akan dimulai dari kolom ke 5 sampai (jmlKolom - 2) , karena 2 kolom terakhir adalah kolom pendamping dan skema
5. Kemudian Dilakukan operasi untuk menghilangkan tanda kutip yang ada dan apabila ada di akhir dan awal kalimat dari judul
6. Kemudian di count untuk jumlah kata dari judul dan ketika ditemukan lebih dari 20 kata maka akan di hapus _ dari namanya dan ditampilkan nama dari mahasiswa dan juga departemennya

**BERIKUT ADALAH CODE FULLNNYA**

```shell
#!/bin/bash

csv_file="../resources/data-pkm.csv"

awk -F ',' 'NR==1 {
    for (i=1; i<=NF; i++) {
        if ($i == "Judul") { judul_col = i }
        if ($i == "Nama_Pengusul") { nama = i }
        if ($i == "Departemen") { dep = i }
    }
}
NR>1 {

    # Check apabila ternyata lebih dari 7 kolom, kemudian assign tambahan judul
    if(NF > 7) {
        for (i=6; i<=NF-2; i++) {
            $judul_col = $judul_col"," $i
        }
    }

    #Menghilangkan tanda kutip di awal dan di akhir
    while(substr($judul_col, 1, 1) == "\"" || substr($judul_col, length($judul_col), 1) == "\"" ) {
       sub(/^"/, "", $judul_col)
       sub(/"$/, "", $judul_col)
    }

    num_words = split($judul_col, words, " ")
    if (num_words > 20) {
        gsub("_", " ", $nama)
        print $nama, $dep
    }
}' "$csv_file"

```

**PENJELASAN CODE**

1. `#!/bin/bash`: Ini adalah line yang menunjukkan bahwa script ini harus dijalankan menggunakan bash shell.

2. `csv_file="../resources/data-pkm.csv"`: Variabel yang menentukan lokasi file CSV yang akan diproses.

3. `awk -F ',' 'NR==1 { ... } NR>1 { ... }' "$csv_file"`: Memulai pemrosesan menggunakan AWK dengan delimiter koma (`,`). AWK akan melakukan dua hal: pertama, memproses baris header (NR==1), dan kedua, memproses baris-baris selanjutnya (NR>1).

4. `for (i=1; i<=NF; i++) { ... }`: Loop melalui setiap kolom di baris pertama (header) untuk menentukan indeks kolom yang sesuai dengan judul, nama pengusul, dan departemen.

5. `if(NF > 7) { ... }`: Memeriksa apakah jumlah kolom pada baris melebihi 7. Jika iya, maka kode ini akan menangani tambahan judul yang ada.

6. `while(substr($judul_col, 1, 1) == "\"" || substr($judul_col, length($judul_col), 1) == "\"" ) { ... }`: Loop untuk menghilangkan tanda kutip di awal dan akhir dari judul.

7. `num_words = split($judul_col, words, " ")`: Menghitung jumlah kata dalam judul dengan membaginya berdasarkan spasi.

8. `if (num_words > 20) { ... }`: Memeriksa apakah judul memiliki lebih dari 20 kata.

9. `gsub("_", " ", $nama)`: Mengganti garis bawah (`_`) dengan spasi dalam nama pengusul.

10. `print $nama, $dep`: Menprint nama pengusul dan departemen jika judul memenuhi syarat yaitu melebihi 20 kata.

**OUTPUT CODE**


<br>
<br>
<br>

## **SOAL 1B**


- b. Komandan PKM juga tertarik ingin tahu antusiasme dan partisipasi mahasiswa sehingga meminta Bubu menampilkan bidang paling banyak diminati oleh mahasiswa. Tampilkan nama skema saja.

  _b. The PKM commander is also interested in knowing the enthusiasm and participation of students, so he asks Bubu to display the most popular field among students. Display only the scheme names._




## PENYELESAIAN 1B

  ### Langkah - langkah 
  1. Inisialisasi deklarasi path untuk csv file
  2. Kemudian membuat perulangan untuk mendapatkan index skema dari header csv
  3. Setelah ditemukan index dari skema, saya melanjutkan untuk mencari data yang dibutuhkan di baris selanjutnya
  4. Saya deklarasi array count yang memiliki index string yaitu nama - nama pkm yang value dari array nya adalah integer yang menandakan jumlah atau frekuensi dari nama pkm tertentu, jadi semakin banyak nama pkm tertentu ada di csv maka jumlah value atau frekuensi nya akan meningkat
  5. Kemudian saya memberikan perintah ketika program sudah selesai yaitu setelah END
  6. Dimana saya deklarasi var max_count yang digunakan sebagai parameter frekuensi tertinggi atau sebagai pembanding frekuensi antar judul pkm
  7. Kemudian dilakukan perulangan untuk mendapatkan value dari array count dan di loop menggunakan loop for untuk terus membandingkan value tiap index yang ada di count untuk di assign ke max_count sebagai value yang tertinggi atau frekuensi tertinggi
  8. Di dalam perulangan itu juga dibuat variable bidang_paling_diminati untuk assign nama PKM yang memiliki frekuensi tertinggi
  9. Setelah loop for selesai, akan di print nama PKM yang memiliki nilai tertinggi



**BERIKUT ADALAH CODE FULLNNYA**

```shell
#!/bin/bash

csv_file="../resources/data-pkm.csv"

awk -F ',' 'NR == 1 {
    for (i=1; i<=NF; i++) {
    if ($i == "Skema") { skema_pkm = i}
    }
}
NR > 1 {
    count[$skema_pkm]++;
} 
END {
    max_count=-1;
    for (skema in count) {
        if (count[skema] > max_count) {
            max_count=count[skema];
            bidang_paling_diminati=skema
        }
    }
    print bidang_paling_diminati
}' "$csv_file"


```

<br>

**PENJELASAN CODE**


1. `#!/bin/bash`: Ini adalah line yang menunjukkan bahwa script ini harus dijalankan menggunakan bash shell.

2. `csv_file="../resources/data-pkm.csv"`: Variabel yang menentukan lokasi file CSV yang akan diproses.

3. `awk -F ',' 'NR==1 { ... } NR>1 { ... }' "$csv_file"`: Memulai pemrosesan menggunakan AWK dengan delimiter koma (`,`). AWK akan melakukan dua hal: pertama, memproses baris header (NR==1), dan kedua, memproses baris-baris selanjutnya (NR>1).

4. `for (i=1; i<=NF; i++) { ... }`: Loop melalui setiap kolom di baris pertama (header) untuk menentukan indeks kolom yang sesuai dengan nama skema atau judul PKM.
   
5. `count[$skema_pkm]++;` : Menghitung jumlah frekuensi untuk setiap skema PKM di setiap baris, dengan menggunakan indeks kolom yang sudah ditemukan sebelumnya.
   
6. `max_count=-1;`: Inisialisasi variabel max_count dengan nilai terkecil yaitu saya inisialisasi dengan -1.

7. `for (skema in count) { ... }`: Loop melalui setiap frekuensi dalam array `count` untuk mencari skema PKM dengan jumlah frekuensi terbanyak.

8. `if (count[skema] > max_count) { ... }`: Membandingkan jumlah frekuensi skema saat ini dengan `max_count` untuk menentukan skema mana yang memiliki jumlah frekuensi terbanyak.

9.  `max_count=count[skema]; bidang_paling_diminati=skema`: Memperbarui nilai `max_count` dan `bidang_paling_diminati` jika jumlah frekuensi skema saat ini lebih besar dari `max_count`.

10. `print bidang_paling_diminati`: Menprint skema PKM yang paling diminati setelah selesai memproses semua baris dalam file CSV.

<br>
<br>

**OUTPUT CODE**



<br>
<br>
<br>




## **SOAL 1C**

- c. Karena ada aturan baru dimana 1 mahasiswa hanya boleh submit 1 proposal, maka komandan juga meminta Bubu untuk memberikan list mahasiswa yang mengajukan 2 proposal. Tampilkan data pembimbingnya karena ingin di kontak komandan.

  _c. Due to a new rule where each student can only submit one proposal, the commander also asks Bubu to provide a list of students who have submitted 2 proposals. Display their supervisor's data as the commander wants to contact them._




## PENYELESAIAN 1C

  ### Langkah - langkah 
  1. Inisialisasi deklarasi path untuk csv file
  2. Kemudian membuat perulangan untuk mendapatkan index Nama Pengusul dan index dari Pendamping dari header csv
  3. Setelah ditemukan index Nama Pengusul dan index dari Pendamping, saya melanjutkan untuk mencari data yang dibutuhkan di baris selanjutnya
  4. Selanjutnya saya deklarasi  array count yang menghitung frekuensi dari nama pengusul dimana ini akan mencari apabila ada nama pengusul yang lebih dari 1
  5. Setelah itu saya membuat if condition yang mana memiliki syarat apabila ditemukan ada nama pengusul yang muncul dua kali
  6. Jika memenuhi syarat dari if tersebut maka akan langsung di print nama pembimbing pertama yang diambil dari value array pembimbing sebagai store atau penyimpanan sementara dari nama pengusul itu dan print pendamping yang kedua
  7. Jika tidak memenuhi syarat dari if itu, maka akan masuk ke kondisi else yang mana saya deklarasi array pembimbing yang mana akan memasukkan nama pembimbing pertama ke dalam array pembimbing yang memiliki index nama pengusul dan memiliki value nama pembimbing



**BERIKUT ADALAH CODE FULLNNYA**

```shell
#!/bin/bash

csv_file="../resources/data-pkm.csv"

awk -F ',' '
NR == 1 {
    for (i=1; i<=NF; i++) {

        if ($i == "Nama_Pengusul") { nama = i }
        if ($i == "Pendamping") { pend = i }
    }
}

NR > 1 {
    count[$nama]++; 
    if (count[$nama] == 2) {
            print pembimbing[$nama];
            print $pend;
    }
    else{
    pembimbing[$nama] = $pend;
    }
}' "$csv_file"

```

<br>

**PENJELASAN CODE**


1. `#!/bin/bash`: Ini adalah line yang menunjukkan bahwa script ini harus dijalankan menggunakan bash shell.

2. `csv_file="../resources/data-pkm.csv"`: Variabel yang menentukan lokasi file CSV yang akan diproses.

3. `awk -F ',' 'NR==1 { ... } NR>1 { ... }' "$csv_file"`: Memulai pemrosesan menggunakan AWK dengan delimiter koma (`,`). AWK akan melakukan dua hal: pertama, memproses baris header (NR==1), dan kedua, memproses baris-baris selanjutnya (NR>1).

4. `for (i=1; i<=NF; i++) { ... }`: Loop melalui setiap kolom di baris pertama (header) untuk menentukan indeks kolom yang sesuai dengan nama pengusul pkm dan nama dari pendamping pengusul.

5. `count[$nama]++;`: Menghitung jumlah frekuensi setiap nama pengusul.

6. `if (count[$nama] == 2) { ... }`: Jika jumlah frekuensi nama pengusul sudah mencapai 2, maka print nilai dari pembimbing sebelumnya dan print nilai dari pendamping.

7.  `print pembimbing[$nama]; print $pend;`: Menprint nilai dari pembimbing yang sebelumnya disimpan dalam array `pembimbing`, dan menprint nilai dari pendamping saat ini.

8.  `else { pembimbing[$nama] = $pend; }`: Jika jumlah frekuensi nama pengusul belum mencapai 2, maka simpan nilai dari pendamping dalam array `pembimbing` dengan index nama pengusul tersebut.



<br>
<br>

**OUTPUT CODE**




<br>
<br>
<br>
<br>
<br>
<br>

# **TASK 2**
# **Dikerjakan Oleh MUHAMMAD AQIL FARRUKH 5025221158**
## Gabut Yuan _(Yuan's Boredom)_

Yuan sedang gabut dan lagi makan toge. Setelah kenyang, dia ingin menambah suatu kerjaan baru. Dia sebagai panitia KSN ingin membuat suatu website yang handle login dan register untuk proposal PKM. [File](/resources/data-pkm.csv) yang digunakan sama seperti di nomor 1, hanya saja Yuan ingin memodifikasi file ini:

_Yuan is feeling idle and is currently eating bean sprouts. After feeling full, he wants to add a new task. As a committee member of KSN, he wants to create a website that handles login and registration for PKM proposals. The [file](/resources/data-pkm.csv) used is the same as in question 1, however, Yuan wants to modify this file:_

- a. Yuan ingin membuat file bash login bernama [yu_login.sh](./yu_login.sh) untuk memastikan bahwa peserta yang telah ada di dalam file .csv tersebut, dapat langsung melakukan login, tanpa perlu register. Apabila loginnya sukses, maka akan masuk ke log.txt. Berikut format untuk login:

  _a. Yuan wants to create a bash login file named [yu_login.sh](./yu_login.sh) to ensure that participants already listed in a .csv file can directly log in without needing to register. If the login is successful, the details will be logged into log.txt. Here's the format for the login:_

  - Memasukkan username. Username didapatkan dari kata pertama pada kolom nama_pengusul

    _Yuan wants to adjust the bash login script to include a process where the username is derived from the first word of the nama_pengusul column in a .csv file._

  - Memasukkan password. Password didapatkan dari fakultas+nipd_dosen_pendamping

    Misal: `FTEIC0030016403`

    _Yuan intends to incorporate a step for password entry in the bash script, where the password is constructed by concatenating the faculty name with the mentor's NIPD._

    _Example: `FTEIC0030016403`_

  - Setiap percobaan login akan tercatat pada log.txt dengan format `YY/MM/DD hh:mm:ss MESSAGE`

    _Every login attempt will be recorded in log.txt with the format `YY/MM/DD hh:mm:ss MESSAGE`._

    Dengan MESSAGE berupa:

    _With the following MESSAGE:_

    `LOGIN: SUCCESS USER_NAME is logged in`

    Atau

    _Or_

    `LOGIN: ERROR Failed login attempt on USER_NAME`

- b. Yuan juga ingin membuat file bash register bernama [yu_register.sh](./yu_register.sh) untuk handle peserta baru yang ingin upload proposal. Data baru ini akan langsung disimpan dalam file .csv tersebut. Ketentuannya adalah:

  _b. Yuan also wants to create a bash file named yu_register.sh to handle new participants who want to upload proposals. This new data will be directly saved in the .csv file. The requirements are:_

  - Memasukkan nama_pengusul, asal departemen, fakultas, judul proposal, dosen pendamping (nidn), skema pkm. (Sesuaikan dengan file .csv)

    _Enter the proposer's name (nama_pengusul), home department (asal_departemen), faculty (fakultas), proposal title (judul_proposal), mentoring lecturer (NIDN) (dosen_pendamping (NIDN)), and PKM scheme (skema_pkm). (Align with the .csv file)_

  - Setiap percobaan register akan tercatat pada log.txt dengan format `YY/MM/DD hh:mm:ss MESSAGE`

    _Every registration attempt will be recorded in log.txt with the format `YY/MM/DD hh:mm:ss MESSAGE`._

    Dengan MESSAGE berupa:

    _With the following MESSAGE:_

    `REGISTER: SUCCESS USER_NAME is registered. Proposal PROPOSAL_NUMBER is added`

    Atau

    _Or_

    `REGISTER: ERROR USER_NAME is already existed`

- c. Yuan tidak ingin capek. Dia membuat automasi di file bash bernama [yu_database.sh](./yu_database.sh) untuk dapat membuat file users.txt guna menyimpan username dan password dari para peserta. Ketentuannya adalah:

  _c. Yuan doesn't want to get tired. He's creating automation in a bash file named [yu_database.sh](./yu_database.sh) to generate a users.txt file for storing usernames and passwords of the participants. The requirements are:_

  - File users.txt akan diupdate setiap 1 jam sekali

    _The users.txt file will be updated every 1 hour._

  - Simpan konfigurasi cron pada file [crontabs](./crontabs)

    _Save the cron configuration in the [crontabs](./crontabs) file._


## **SOAL 2A**
- a. Karena Belmawa menetapkan judul maksimum proposal 20 kata, maka komandan ingin mencari data siapa saja tim yang tidak memenuhi ketentuan ini. Tampilkan nama pengusul, beserta departemennya yang judulnya lebih dari 20 kata. Pisahkan spasi dan hapus underscore "\_" pada nama pengusul.

  _a. Because Belmawa sets the maximum proposal title to 20 words, the commander wants to find out which teams do not meet this requirement. Display the names of the proposers along with their departments whose titles are more than 20 words. Separate with spaces and remove underscores "\_" from the proposers' names._

## PENYELESAIAN 2A

  ### Langkah - langkah 
1. Inisialisasi deklarasi path untuk csv file
2. Kemudian deklarasi variable string real_password sebagai password yang sudah ada di database csv
3. Untuk langkah awal, saya membuat fungsi main atau fungsi utama yaitu main dimana saya namai dengan nama login yang akan langsung dipanggil di akhir baris
4. Di dalam fungsi login ini disediakan input untuk memasukkan username dan password yang nama variable untuk input juga sama yaitu username dan password untuk login
5. kemudian akan dipanggil fungsi untuk mencari find user dimana akan passing value username  dan password yang telah diinputkan 
6. Kemudian saya membuat fungsi find_user untuk mencari kevalidan data dari username dan password yang telah diinputkan
7. Di dalam fungsi find user ini menerima passing variable pertama yaitu username dan kedua yaitu password, kemudian untuk mengecek apakah berhasil dipassing saya menggunakan echo atau langsung print variable dari username dan password
8. Kemudian setelah dua variable sebelumnya diterima oleh fungsi , kemudian akan dilakukan perulangan dengan while dan separator `,` untuk membaca file csv 
9. Dalam perulangan itu dilakukan pengecekan pertama yaitu username dimana daftar per nama pengusul yang ada di csv akan dipotong dan disisakan kata pertama saja untuk dicocokkan dengan username yang telah diinputkan
10. Jika ditemukan dan cocok antara username dan nama yang telah dipotong dari csv, akan dilanjutkan pengecekan kecocokan dari password
11. Caranya adalah dengan mengambil value fakultas yang ada di csv dan pendamping dari csv juga. Kemudian break perulangan while karena telah ditemukan kecocokan data.
12. Setelah itu akan dipassing value dari fakultas dan pendamping yang sudah ditemukan di while ke fungsi calculate_pasword yang mana ini akan generate password untuk mencari kecocokan data antar password yang ada di database csv dan password yang telah diinputkan
13. Kemudian saya membuat fungsi calculate password yang akan menerima 2 value yaitu pendamping dan fakultas, disini akan dipotong dan diambil nomor dosen yang ada di variable pendamping kemudian disandingkan dengan fakultas dimana `fakultas + nomor dosen ` sebagai real_password yang sudah di declare variable nya secara global sebelumnya
14. Kemudian saya juga mengecek apakah data password ditemukan dengan baik untuk pendamping , fakultas, dan nomor dosen dengan cara echo atau print 3 var itu
15. Karena variable real_password sudah ditemukan dan di calculte, saya lalu melanjutkan baris code yang ada di fungsi utama yaitu login
16. Saya menambahkan kondisi if apabila password yang diinputkan sama dengan password yang telah dicalculate atau real_password maka akan dilakukan log message ke file log.txt dimana saya akan membuat fungsi singkat untuk log_message
17. Di fungsi log message ini saya melakukan input atau memasukkan data tanggal dan waktu dan juga menerima passing value dari log message yang berhasil login maupun yang gagal kemudian di write ke dalam file log.txt
18. Melanjutkan baris code yang ada di main , dimana saya menulis pemanggilan fungsi log_message dengan passing value dari message log untuk di write ke file log.txt
19. Tapi jika tidak ditemukan kecocokan antara password yang diinputkan dengan real_password, maka akan masuk ke kondisi else yang mana akan memanggil log.txt untuk write kegagalan yang terjadi ketika login beserta username yang telah diinputkan. Setelah itu program selesai digunakan apabila telah login atau gagal login.

**BERIKUT ADALAH CODE FULLNNYA**

```shell
#!/bin/bash

# CSV FILE
csv_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/resources/data-pkm.csv"

real_password=""
# LOG MESSAGE
log_message() {
    echo "$(date +"%y/%m/%d %H:%M:%S") $1" >>log.txt
}

# CALCULATE PASSWORD
calculate_password() {
    local pend=$1
    local fakultas=$2
    local nomor_dosen
    nomor_dosen=$(echo "$pend" | grep -o '\([0-9]\{10\}\)')
    real_password="$fakultas$nomor_dosen"
    echo "pendamping: $pend"
    echo "fakultas: $fakultas"
    echo "nomor dosen: $nomor_dosen"
}

# FIND USER
find_user() {
    local username=$1
    local password=$2
    echo "Username: $username"
    echo "Password: $password"

    # Loop through the CSV file
    while IFS=',' read -r -a array; do
        if [[ "$(echo ${array[1]} | cut -d'_' -f1)" == "$username" ]]; then
            fakultas="${array[3]}"
            pend="${array[5]}"
            break
        fi
    done <"$csv_file"
    calculate_password "$pend" "$fakultas"

}

#LOGIN
login() {
    read -r -p "Masukkan username: " username
    read -r -p "Masukkan password: " password
    echo

    # Mencetak username dan password yang diinputkan
    find_user "$username" "$password"
    if [ "$password" = "$real_password" ]; then
        log_message "LOGIN: SUCCESS $username is logged in"
    else
        log_message "LOGIN: ERROR Failed login attempt on $username"
        #echo "ERROR: Invalid username or password."
        exit 1
    fi
}

#menjalankan fungsi login
login


```

**PENJELASAN CODE**

1. `#!/bin/bash`: Ini adalah baris yang memberitahu sistem bahwa skrip ini adalah script bash shell.

2. `csv_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/resources/data-pkm.csv"`: Ini mendefinisikan variabel `csv_file` yang menyimpan path lengkap ke file CSV yang akan digunakan.

3. `real_password=""`: Inisialisasi variabel `real_password` sebagai string kosong untuk menyimpan password yang akan dihitung nanti.

4. `log_message() {`: Declare fungsi bernama `log_message`. Fungsi ini digunakan untuk mencatat pesan log dan write log message ke log.txt.

5. `echo "$(date +"%y/%m/%d %H:%M:%S") $1" >>log.txt`: Ini mencetak pesan log dengan format waktu (tanggal dan jam) disertai dengan pesan yang diinputkan sebagai argumen pertama ke file `log.txt`.

6. `calculate_password() {`: Ini adalah awal definisi fungsi bernama `calculate_password`. Fungsi ini bertanggung jawab untuk menghitung password berdasarkan variable fakultas dan pendamping yang  diambil dari csv.

7. `local pend=$1`: Mendeklarasikan variabel lokal `pend` yang diinisialisasi dengan nilai dari argumen pertama fungsi `calculate_password`.

8. `local fakultas=$2`: Mendeklarasikan variabel lokal `fakultas` yang diinisialisasi dengan nilai dari argumen kedua fungsi `calculate_password`.

9. `local nomor_dosen`: Mendeklarasikan variabel lokal `nomor_dosen`.

10. `nomor_dosen=$(echo "$pend" | grep -o '\([0-9]\{10\}\)')`: Ini mengekstrak nomor dosen (sepuluh digit numerik) dimana keteraturan dari semua data dari csv memiliki 10 digit untuk nomor dosen dari string `pend` menggunakan ekspresi reguler dan menyimpannya dalam variabel `nomor_dosen`.

11. `real_password="$fakultas$nomor_dosen"`: Menggabungkan nilai dari `fakultas` dan `nomor_dosen` untuk membentuk real_password, yang disimpan dalam variabel `real_password`.

12. `find_user() {`: Deklarasi fungsi bernama `find_user`. Fungsi ini bertanggung jawab untuk mencari user berdasarkan username yang diinputkan.

13. `local username=$1`: Mendeklarasikan variabel lokal `username` yang diinisialisasi dengan nilai dari argumen pertama fungsi `find_user`.

14. `local password=$2`: Mendeklarasikan variabel lokal `password` yang diinisialisasi dengan nilai dari argumen kedua fungsi `find_user`.

15. `while IFS=',' read -r -a array; do`: Memulai loop while untuk membaca file CSV baris demi baris dengan separator `,`.

16. `if [[ "$(echo ${array[1]} | cut -d'_' -f1)" == "$username" ]]; then`: Memeriksa apakah username dalam file CSV yang dipotong dan diambil kata pertamanya cocok dengan username yang diinputkan.

17. `fakultas="${array[3]}"`: Mengambil nilai fakultas dari array berdasarkan indeks 3.

18. `pend="${array[5]}"`: Mengambil nilai pendamping dari array berdasarkan indeks 5.

19. `break`: Menghentikan loop saat user ditemukan.

20. `done <"$csv_file"`: Menutup loop while dan mendefinisikan file CSV yang digunakan sebagai input.

21. `calculate_password "$pend" "$fakultas"`: Memanggil fungsi `calculate_password` dengan argumen `pend` dan `fakultas` yang diperoleh dari pencarian user sebelumnya.

22. `login() {`:Deklarasi fungsi bernama `login`. Fungsi ini bertanggung jawab untuk melakukan proses login.

23. `read -r -p "Masukkan username: " username`: Membaca input dari user untuk username.

24. `read -r -p "Masukkan password: " password`: Membaca input dari user untuk password.

25. `find_user "$username" "$password"`: Memanggil fungsi `find_user` dengan username dan password yang diinputkan.

26. `if [ "$password" = "$real_password" ]; then`: Memeriksa apakah password yang diinputkan oleh user cocok dengan `real_password` yang telah dikalkulasi dan di generate di fungsi `calculate_password` sebelumnya.

27. `log_message "LOGIN: SUCCESS $username is logged in"`: Mencatat pesan log jika login berhasil.

28. `log_message "LOGIN: ERROR Failed login attempt on $username"`: Mencatat pesan log jika login gagal.

29. `exit 1`: Keluar dari skrip dengan status keluaran 1 jika login gagal.

30. `login`: Memanggil fungsi `login` untuk memulai proses login ketika skrip dijalankan.



<br>
<br>

**OUTPUT CODE**


<br>
<br>
<br>




## **SOAL 2B**
- b. Yuan juga ingin membuat file bash register bernama [yu_register.sh](./yu_register.sh) untuk handle peserta baru yang ingin upload proposal. Data baru ini akan langsung disimpan dalam file .csv tersebut. Ketentuannya adalah:

  _b. Yuan also wants to create a bash file named yu_register.sh to handle new participants who want to upload proposals. This new data will be directly saved in the .csv file. The requirements are:_

  - Memasukkan nama_pengusul, asal departemen, fakultas, judul proposal, dosen pendamping (nidn), skema pkm. (Sesuaikan dengan file .csv)

    _Enter the proposer's name (nama_pengusul), home department (asal_departemen), faculty (fakultas), proposal title (judul_proposal), mentoring lecturer (NIDN) (dosen_pendamping (NIDN)), and PKM scheme (skema_pkm). (Align with the .csv file)_

  - Setiap percobaan register akan tercatat pada log.txt dengan format `YY/MM/DD hh:mm:ss MESSAGE`

    _Every registration attempt will be recorded in log.txt with the format `YY/MM/DD hh:mm:ss MESSAGE`._

    Dengan MESSAGE berupa:

    _With the following MESSAGE:_

    `REGISTER: SUCCESS USER_NAME is registered. Proposal PROPOSAL_NUMBER is added`

    Atau

    _Or_

    `REGISTER: ERROR USER_NAME is already existed`

## PENYELESAIAN 2B

  ### Langkah - langkah 
1. Inisialisasi deklarasi path untuk csv file
2. Kemudian deklarasi variable sudah_ada sebagai penanda atau boolean bahwa sudah ada user dengan nama itu di database csv dengan default falue false
3. Untuk langkah awal, saya membuat fungsi main atau fungsi utama yaitu main dimana saya namai dengan nama register yang akan langsung dipanggil di akhir baris
4. Di dalam fungsi register ini disediakan input untuk memasukkan nama mahasiswa, departemen, fakultas, judul proposal, dosen pendamping, dan nama pkm
5. kemudian akan dipanggil fungsi untuk mencari find user dimana akan passing value nama, fakultas, dan dosen pendamping yang telah diinputkan 
6. Kemudian saya membuat fungsi find_user untuk mencari kevalidan data dari nama, fakultas, dan dosen pendamping yang telah diinputkan
7. Di dalam fungsi find user ini menerima passing variable pertama yaitu username kedua yaitu fakultas, kemudian pendamping sebagai yang ketiga
8. Kemudian saya declare var dengan nama nomorReg yang akan mengambil angka atau nomor dosen dari var pendamping yang memiliki pola 10 digit dan ada di dalam tanda kurung
9. Kemudian saya declare regpass sebagai password yang telah digenerate dengan cara menambah `fakultas + nomor dosen ` . Fakultas dan nomor dosen ini diambil dari variable yang dipassing alias yang telah diinputkan sebelumnya
10. Kemudian akan dilakukan perulangan while dengan separator `,` untuk mencari apakah sudah ada username yang sama di dalam database dan passwordnya juga
11. Dalam perulangan itu dilakukan pengecekan pertama yaitu username dimana daftar per nama pengusul yang ada di csv akan dipotong dan disisakan kata pertama saja untuk dicocokkan dengan username yang telah diinputkan yang mana saya declare dengan nama var searchName
12. Jika ditemukan dan cocok antara username dan nama yang telah dipotong dari csv, akan dilanjutkan pengecekan kecocokan dari password
13. Caranya adalah dengan mengambil value fakultas yang ada di csv dan pendamping dari  csv. Kemudian akan digenerate password dengan cara yang sama yaitu menambah `fakultas + nomor dosen ` kemudian dicocokan apakah password yang ada di csv sama dengan password yang digenerate dari input.
14. Jika password dan username sama , maka variable sudah_ada akan menjadi true kemudian break while
15. Setelah itu saya akan melanjutkan baris code yang ada di fungsi register dimana ini akan berisi 2 kondisi if dan else.
16. Untuk kondisi if saya mengecek apakah data yang diinputkan sudah ada sebelumnya di dalam csv. Kemudian jika sudah ada, saya akan memanggil log message untuk melaporkan eror dan write message nya ke fungsi log_message
17.  Di fungsi log message ini saya melakukan input atau memasukkan data tanggal dan waktu dan juga menerima passing value dari log message yang berhasil register maupun yang gagal kemudian di write ke dalam file log.txt
18.  Setelah itu, saya melakukan pengecekan jika user yang diinputkan belum ada di database csv. Maka akan memanggil fungsi isSuccess yang menerima parameter value berupa nama, departemen, fakultas, proposal, dosen pendamping, serta judul pkm.
19.  Kemudian saya membuat fungsi isSuccess yang mana akan menghitung terlebih dahulu jumlah baris yang ada di dalam csv. Dimana ini adalah kebutuhan dalam log message yang akan menulis proposal ke sekian yang menandai input data yang baru.
20.  Setelah dihitung jumlah proposalnya, jumlah itu akan diincrement sebanyak satu kali atau ditambah 1 yang mana menjadi tanda bahwa input data adalah baris terbaru yang akan dimasukkan ke dalam csv dan kemudian akan di write ke dalam csv file
21.  Setelah di write ke dalam csv file, akan memanggil langsung log_message yang mengirimkan pesan sukses registrasi dan langsung di write ke log.txt untuk message sukses registernya.


**BERIKUT ADALAH CODE FULLNNYA**

```shell
#!/bin/bash

# CSV FILE
csv_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/resources/data-pkm.csv"

log_message() {
    echo "$(date +"%y/%m/%d %H:%M:%S") $1" >>log.txt
}

# FIND USER
sudah_ada=false
find_user() {
    local username=$1
    local fakultas=$3
    local pend=$2
    local nomorReg=$(echo "$pend" | grep -o '\([0-9]\{10\}\)')
    local reg_pass="$fakultas$nomorReg"
    # echo "Username: $username"
    local reg_name=$(echo "$username" | cut -d'_' -f1)

    # Loop through the CSV file
    while IFS=',' read -r -a array; do
        local searchName=$(echo "${array[1]}" | cut -d'_' -f1)
        if [ $searchName == $reg_name ]; then
            local fakultas_csv="${array[3]}"
            local pend_csv="${array[@]:4}"
            pend_csv="${pend_csv%,*}"
            local nomor_csv=$(echo "$pend_csv" | grep -o '\([0-9]\{10\}\)')
            local pass_csv="$fakultas_csv$nomor_csv"
            if [ $pass_csv == $reg_pass ]; then
                sudah_ada=true
                break
            fi
        fi
    done <"$csv_file"
}

isSuccess() {
    local nama=$1
    local dep=$2
    local fak=$3
    local prop=$4
    local dos=$5
    local pkm=$6
    local jumlah_proposal=$(wc -l <"$csv_file")
    echo "$jumlah_proposal,$nama,$dep,$fak,$prop,$dos,$pkm" >>"$csv_file"
    echo "Sukses Registrasi"
    log_message "REGISTER: SUCCESS $nama is registered. Proposal $jumlah_proposal is added"

}

register() {
    read -p "Masukkan Nama Mahasiswa: " nama
    read -p "Masukkan Nama Departemen: " asal_departemen
    read -p "Masukkan Fakultas: " fakultas
    read -p "Masukkan Judul Proposal: " judul_proposal
    read -p "Masukkan Dosen Pendamping dan (NIPD): " dosen_pendamping
    read -p "Masukkan Skema PKM: " skema_pkm

    find_user "$nama" "$fakultas" "$dosen_pendamping"
    if $sudah_ada; then
        echo "User $nama sudah ada, coba nama yang lain"
        log_message "REGISTER: ERROR $nama is already existed"
        exit 1
    else
        isSuccess "$nama" "$asal_departemen" "$fakultas" "$judul_proposal" "$dosen_pendamping" "$skema_pkm"
    fi

}

register



```

**PENJELASAN CODE**

1. `#!/bin/bash`: Ini adalah baris yang memberitahu sistem bahwa skrip ini adalah script bash shell.

2. `csv_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/resources/data-pkm.csv"`: Variabel `csv_file` menyimpan path ke file CSV yang akan digunakan dalam skrip.

3. `log_message() {`: Ini adalah awal definisi fungsi bernama `log_message`. Fungsi ini bertugas mencatat pesan log ke dalam file `log.txt`.

4. `echo "$(date +"%y/%m/%d %H:%M:%S") $1" >>log.txt`: Ini mencetak pesan log dengan format waktu (tanggal dan jam) disertai dengan pesan log dari register yang sukses maupun yang eror yang diberikan sebagai argumen pertama ke dalam file `log.txt`.

5. `sudah_ada=false`: Variabel `sudah_ada` digunakan untuk menandai apakah username ataupun password sudah ada atau belum saat melakukan pencarian.

6. `find_user() {`: Ini adalah awal definisi fungsi bernama `find_user`. Fungsi ini bertugas untuk mengecek apakah username dan password yang digenerate berdasarkan input akan sama atau sudah ada di dalam csv dengan mencocokkan username dan password yang digenerate berdasarkan database csv

7. `local username=$1`: Mendeklarasikan variabel lokal `username` dan menginisialisasinya dengan argumen pertama yang diterima oleh fungsi.

8. `local fakultas=$3`: Mendeklarasikan variabel lokal `fakultas` dan menginisialisasinya dengan argumen ketiga yang diterima oleh fungsi.

9. `local pend=$2`: Mendeklarasikan variabel lokal `pend` dan menginisialisasinya dengan argumen kedua yang diterima oleh fungsi.

10. `local nomorReg=$(echo "$pend" | grep -o '\([0-9]\{10\}\)')`: Mendeklarasikan variabel lokal `nomorReg` dan menginisialisasinya dengan nomor dosen yang diekstrak dari argumen `pend`.

11. `local reg_pass="$fakultas$nomorReg"`: Mendeklarasikan variabel lokal `reg_pass` yang menyimpan password yang dihasilkan dari `fakultas` dan `nomorReg`.

12. `local reg_name=$(echo "$username" | cut -d'_' -f1)`: Mendeklarasikan variabel lokal `reg_name` yang mengambil kata pertama dari `username`.

13. `while IFS=',' read -r -a array; do`: Memulai loop while untuk membaca file CSV baris demi baris dengan separator `,`

14. `local searchName=$(echo "${array[1]}" | cut -d'_' -f1)`: Mendeklarasikan variabel lokal `searchName` yang mengambil nama username yaitu kata pertama dari username berdasarkan data username yang sudah ada di csv

15. `if [ $searchName == $reg_name ]; then`: Memeriksa apakah nama username  dalam file CSV sama dengan nama username yang telah diinputkan

16. `local fakultas_csv="${array[3]}"`: Mendeklarasikan variabel lokal `fakultas_csv` yang mengambil nilai fakultas dari file CSV.

17. `local pend_csv="${array[@]:4}"`: Mendeklarasikan variabel lokal `pend_csv` yang mengambil nilai pendamping dari file CSV yang mana ini akan menghandle judul yang memiliki banyak koma dan handle separator `,` yang membuat baris itu mempunyai kolom yang banyak karena memmiliki banyak koma.

18. `local nomor_csv=$(echo "$pend_csv" | grep -o '\([0-9]\{10\}\)')`: Mendeklarasikan variabel lokal `nomor_csv` yang mengambil nomor dosen dari nilai `pend_csv` dengan pola angka di dalam kurung.

19. `local pass_csv="$fakultas_csv$nomor_csv"`: Mendeklarasikan variabel lokal `pass_csv` yang menyimpan password yang dihasilkan dari nilai `fakultas_csv` dan `nomor_csv`.

20. `if [ $pass_csv == $reg_pass ]; then`: Memeriksa apakah password yang ditemukan di file CSV sama dengan password yang diinputkan dan digenerate.

21. `sudah_ada=true`: Menetapkan variabel `sudah_ada` ke `true` jika username ataupun password sudah ada dalam file CSV.

22. `isSuccess() {`: Deklarasi fungsi bernama `isSuccess`. Fungsi ini digunakan untuk menambahkan entri baru ke file CSV.

23. `local jumlah_proposal=$(wc -l <"$csv_file")`: Mendeklarasikan variabel lokal `jumlah_proposal` yang menghitung jumlah baris dalam file CSV.

24. `echo "$jumlah_proposal,$nama,$dep,$fak,$prop,$dos,$pkm" >>"$csv_file"`: Menambahkan entri baru ke file CSV dengan nama, departemen, fakultas, judul proposal, dosen pendamping, dan skema PKM yang diinputkan.

25. `echo "Sukses Registrasi"`: Mencetak pesan bahwa registrasi berhasil.

26. `log_message "REGISTER: SUCCESS $nama is registered. Proposal $jumlah_proposal is added"`: Mencatat pesan log bahwa registrasi berhasil.

27. `register() {`: Deklarasi fungsi bernama `register`. Fungsi ini bertugas meminta input dari username ataupun password dan memproses registrasi.

28. `find_user "$nama" "$fakultas" "$dosen_pendamping"`: Memanggil fungsi `find_user` untuk memeriksa apakah username ataupun password sudah ada dalam file CSV.

29. `echo "User $nama sudah ada, coba nama yang lain"`: Mencetak pesan bahwa username ataupun password sudah ada.

31. `log_message "REGISTER: ERROR $nama is already existed"`: Mencatat pesan log bahwa registrasi gagal karena username ataupun password sudah ada.

32. `exit 1`: Keluar dari skrip dengan status keluaran 1 karena registrasi gagal.

33. `isSuccess "$nama" "$asal_departemen" "$fakultas" "$judul_proposal" "$dosen_pendamping" "$skema_pkm"`: Memanggil fungsi `isSuccess` untuk menambahkan entri baru ke file CSV karena registrasi berhasil.

34. `register`: Memanggil fungsi `register` untuk memulai proses registrasi ketika skrip dijalankan.




<br>
<br>

**OUTPUT CODE**


<br>
<br>
<br>














## **SOAL 2C**
- c. Yuan tidak ingin capek. Dia membuat automasi di file bash bernama [yu_database.sh](./yu_database.sh) untuk dapat membuat file users.txt guna menyimpan username dan password dari para peserta. Ketentuannya adalah:

  _c. Yuan doesn't want to get tired. He's creating automation in a bash file named [yu_database.sh](./yu_database.sh) to generate a users.txt file for storing usernames and passwords of the participants. The requirements are:_

  - File users.txt akan diupdate setiap 1 jam sekali

    _The users.txt file will be updated every 1 hour._

  - Simpan konfigurasi cron pada file [crontabs](./crontabs)

    _Save the cron configuration in the [crontabs](./crontabs) file._

## PENYELESAIAN 2C

  ### Langkah - langkah 
1. Inisialisasi deklarasi path untuk csv file
2. Inisialisasi deklarasi path untuk user_file alias users.txt yang akan menjadi tempat untuk penulisan data username dan password
3. Untuk langkah awal, saya membuat fungsi main atau fungsi utama yaitu main dimana saya namai dengan nama update_all_users yang akan langsung dipanggil di akhir baris
4. Di dalam fungsi update_all_users akan saya akan menghapus users.txt yang sebelumnya sudah ada
5. Kemudian saya deklarasi isHeader dengan default value true, ini adalah cara untuk skip header file agar tidak ikut diproses di perulangan while nanti
6. Setelah itu saya melakukan perulangan dengan while untuk membaca csv file dengan separator `,` kemudian akan skip header dan set isHeader menjadi false karena sudah di skip
7. Setelah itu saya mengambil value dari nama, fakultas, dan pendamping yang juga sudah solve bug apabila ada judul yang memiliki banyak koma karna separator saya juga menggunakan koma dalam membaca csv
8. kemudian saya memanggil fungsi calculate password tiap perulangan yang mana akan menggenerate password dari data itu, dimana fungsi calculate password ini akan menerima 3 value yaitu nama, fakultas , dan pendamping
9. Kemudian saya deklarasi fungsi calculate_password yang digunakan untuk generate password dengan mengambil nomor dosen dan menggabungkan nama fakultas ditambah dengan nomor dosen sebagai password
10. Setelah selesai generate password, akan memanggil fungsi send_file yang menerima 2 variable yaitu username dan password yang sudah digenerate
11. Kemudian saya deklarasi fungsi send_file yang akan mengirimkan data username dan password yang akan di write ke file users.txt
12. Kemudian saya membuat crontabs dengan menggunakan nano untuk membuatnya , dimana ini akan menjalan file yu_database.sh setiap satu jam sekali

**BERIKUT ADALAH CODE FULLNNYA (yu_database.sh)**

```shell
#!/bin/bash

# Path to the CSV FILE
csv_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/resources/data-pkm.csv"

# Path to the USER FILE
user_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-2/users.txt"

# Function to send username and password to the user file
send_file() {
    local username=$1
    local password=$2
    echo "$username:$password" >>"$user_file"
}

# Function to calculate the password
calculate_password() {
    local pend=$1
    local fakultas=$2
    local mhs=$3
    local nomor_dosen
    nomor_dosen=$(echo "$pend" | grep -o '\([0-9]\{10\}\)')
    local username=$(echo "$mhs" | cut -d'_' -f1)
    real_password="$fakultas$nomor_dosen"
    echo "mahasiswa: $mhs"
    echo "real password: $real_password"
    send_file "$username" "$real_password"
    # echo "pendamping: $pend"
    # echo "pendamping: $pend"
    # echo "fakultas: $fakultas"
    # echo "nomor dosen: $nomor_dosen"
}

# Function to update all users
update_all_users() {
    # Clear the existing user file
    >"$user_file"

    isHeader=true
    while IFS=',' read -r -a array; do
        if ($isHeader); then
            isHeader=false
            continue
        fi
        nama="${array[1]}"
        fakultas="${array[3]}"
        pend="${array[@]:4}"
        pend="${pend%,*}"

        calculate_password "$pend" "$fakultas" "$nama"
    done <"$csv_file"
}

# Update all users initially
update_all_users



```

<br>
<br>
<br>
<br>


**BERIKUT ADALAH CODE FULLNNYA (CRONTABS UNTUK TASK 2)**

<br>
<br>

```shell
0 * * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-2/yu_database.sh

```

<br>
<br>


**PENJELASAN CODE (yu_database.sh dan crontabs)**

1. `#!/bin/bash`: Ini adalah baris yang memberitahu sistem bahwa skrip ini adalah script bash shell.

2. `csv_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/resources/data-pkm.csv"`: Variabel `csv_file` menyimpan path ke file CSV yang akan digunakan dalam skrip.

3. `user_file="/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-2/users.txt"`: Variabel yang menyimpan path ke file users.txt yang berisi informasi username dan password.

4. `send_file() {`: Fungsi untuk menambahkan username dan password ke file users.txt

5. `echo "$username:$password" >>"$user_file"`: Menambahkan baris baru yang berisi username dan password ke file username dan password.

6. `calculate_password() {`: Fungsi untuk genearate password untuk setiap username dan password.

7.  `nomor_dosen=$(echo "$pend" | grep -o '\([0-9]\{10\}\)')`: Mendeklarasikan variabel `nomor_dosen` dan mengambil nomor dosen dari string `pend`.

8.  `local username=$(echo "$mhs" | cut -d'_' -f1)`: Mendeklarasikan variabel `username` dan mengambil kata pertama dari string `mhs`.

9.  `real_password="$fakultas$nomor_dosen"`: Menggabungkan nilai dari `fakultas` dan `nomor_dosen` untuk membentuk password, yang disimpan dalam variabel `real_password`.

10. `send_file "$username" "$real_password"`: Memanggil fungsi `send_file` untuk write data username dan password ke file users.txt.

11. `update_all_users() {`: Fungsi utama untuk memperbarui informasi username dan password.

12. `>"$user_file"`: Mengosongkan isi file users.txt
    
13. `isHeader=true`: Variabel untuk menandai apakah baris saat ini adalah baris header di file CSV.

14. `while IFS=',' read -r -a array; do`: Memulai loop while untuk membaca file CSV baris demi baris.

15. `if ($isHeader); then`: Memeriksa apakah baris saat ini adalah baris header.

16. `isHeader=false`: Menetapkan variabel `isHeader` menjadi `false` setelah membaca baris header.

17. `continue`: Melanjutkan ke baris berikutnya jika baris saat ini adalah header.

18. `nama="${array[1]}"`: Mendeklarasikan variabel `nama` dan mengambil nama mahasiswa dari array.

19. `fakultas="${array[3]}"`: Mendeklarasikan variabel `fakultas` dan mengambil fakultas dari array.

20. `pend="${array[@]:4}"`: Mendeklarasikan variabel `pend` dan mengambil dosen pendamping dari array.

21. `pend="${pend%,*}"`: Menghapus karakter koma terakhir dari variabel `pend` untuk solve bug judul yang memiliki banyak koma.

22. `calculate_password "$pend" "$fakultas" "$nama"`: Memanggil fungsi `calculate_password` untuk menghitung password berdasarkan data mahasiswa yang diberikan.

23. `done <"$csv_file"`: Menutup loop while dan mendefinisikan file CSV yang digunakan sebagai input.

24. `update_all_users`: Memanggil fungsi `update_all_users` untuk memperbarui informasi username dan password.

25. `0 * * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-2/yu_database.sh` menjalankan crontab satu jam sekali, yaitu tiap di menit 00 dan menjalankan file yu_database.sh



<br>
<br>

**OUTPUT CODE**


<br>
<br>
<br>

<br>
<br>
<br>


# **TASK 4**
# **VERSI 2 oleh MUHAMMAD AQIL FARRUKH 5025221158 (ada di branch update_task4)**
## LDR Isabel _(Isabel Sad Relationship)_

Isabel sedang LDR dengan pacarnya dan sangat rindu. Isabel ingin menyimpan semua foto-foto yang dikirim oleh pacarnya. Bantulah Isabel menyimpan gambar "Mingyu Seventeen”.

_Isabel is in a LDR (Long Distance Relationship) with her boyfriend and really misses him. Isabel wants to keep all the photos her boyfriend sent her. Help Isabel save the picture"Mingyu Seventeen"._

- a. Berikut adalah ketentuan yang diinginkan Isabel:

  _a. The following are the conditions that Isabel wants:_

  - Gambarnya di download setiap 5 jam sekali mulai dari saat script dijalankan dan memperhatikan waktu sekarang. Jika waktu genap, maka simpan foto sebanyak 5x. Jika waktu ganjil, maka simpan foto sebanyak 3x. (Contoh : pukul sekarang 12.38, maka pukul 12 adalah genap sehingga simpan foto sebanyak 5x).

    _The photos are downloaded every 5 hours since the script runs and look at the current time. If the time is even, then save 5x photos. If the time is odd, then save the photo 3 times. (Example: it's 12.38, so 12 o'clock is even so save 5 photos)._

  - Jika pukul menunjukkan 00.00, maka simpan foto sebanyak 10x.

    _If the clock shows 00.00, then save 10 photos._

  - File yang didownload memiliki format nama `foto_NOMOR.FILE` dengan `NOMOR.FILE` adalah urutan file yang download (`foto_1`, `foto_2`, dst)

    _The downloaded files have the format `foto_NOMOR.FILE` where `NOMOR.FILE` is the order of the downloaded file (`foto_1`, `foto_2`, etc)_

  - File batch yang didownload akan dimasukkan ke dalam folder dengan format nama `folder_NOMOR.FOLDER` dengan `NOMOR.FOLDER` adalah urutan folder saat dibuat (`folder_1`, `folder_2`, dst)

    _The downloaded batch files will be placed in a folder with the format name `folder_NOMOR.FOLDER` where `NOMOR.FOLDER` is the order of the folder when created (`folder_1`, `folder_2`, etc)_

- b. Karena memory laptop Isabel penuh, maka bantulah Isabel untuk zip foto-foto tersebut dengan ketentuan:

  _b. Because Isabel's laptop memory is full, help Isabel to zip the photos with the following conditions:_

  - Isabel harus melakukan zip setiap 1 jam dengan nama zip `ayang_NOMOR.ZIP` dengan `NOMOR.ZIP` adalah urutan folder saat dibuat (`ayang_1`, `ayang_2`, dst). Yang di ZIP hanyalah folder dari soal di atas.

    _Isabel must zip every 1 hour with the name `ayang_NOMOR.ZIP` where `NOMOR.ZIP` is the order of the folder when created (`ayang_1`, `ayang_2`, etc). Only the folders from the above question are zipped._

- c. Ternyata laptop Isabel masih penuh, bantulah dia untuk delete semua folder dan zip setiap hari pada pukul 02.00!

  _c. It turns out Isabel's laptop is still full, help her to delete all folders and zips every day at 02.00!_

- d. Untuk mengisi laptopnya kembali, Isabel ingin mendownload gambar Levi dan Eren secara bergantian setiap harinya dengan ketentuan nama file:

  _d. To fill her laptop back, Isabel wants to download Levi and Eren's pictures alternately every day with the following file name conditions:_

  - Jika Levi, maka nama file nya menjadi `levi_YYYYMMDD` (Dengan `YYYYMMDD` adalah tahun, bulan, dan tanggal gambar tersebut di download)

    _If Levi, then the file name becomes `levi_YYYYMMDD` (With `YYYYMMDD` being the year, month, and date the picture was downloaded)_

  - Jika Eren, maka nama file nya menjadi `eren_YYYYMMDD` (Dengan `YYYYMMDD` adalah tahun, bulan, dan tanggal gambar tersebut di download)

    _If Eren, then the file name becomes `eren_YYYYMMDD` (With `YYYYMMDD` being the year, month, and date the picture was downloaded)_

Note: Semua gambar yang didownload bisa dicari bebas dari internet

_Note: All images that need to be downloaded can be freely searched from the internet_



## PENYELESAIAN TASK-4

  ### Langkah - langkah 
  1. Karena untuk task 4 ini diberitahu di discord untuk menjadikan semua nya jadi 1 file, maka saya menyiapkan hanya 1 file dan menghapus yang lain. Dan saya akan membuat crontabs nya ketika semua fungsi yang dibutuhkan sudah selesai
  2. Saya memulai mengerjakan poin A dimana ini membutuhkan suatu fungsi untuk download foto sebanyak 5 kali dan membuat folder sekaligus
  3. Untuk langkah awal saya membuat fungsi download photos dimana ini akan handle download photos yang sebanyak 5 apabila jam saat ini genap dan 3 apabila ganjil
  4. Kemudian saya deklarasi current hour sebagai waktu jam saat ini sebagai var global agar reusable untuk fungsi lain
  5. Begitu juga saya deklarasi fungsi make_folder untuk membuat folder berdasarkan variable folder_count yang sebagai variable global untuk menghitung jumlah folder saat ini
  6. Kemudian di dalam fungsi download photos saya mencari foto terlebih dahulu barulah membuat perulangan untuk mendownload foto itu sebanyak variable photocount yang bergantung pada current hour
  7. Setiap perulangan akan mendownload file foto dengan format penulisan foto_1 foto_2 dan format file .png kemudian setelah selesai perulangan akan dipanggil fungsi make_folder untuk membuat folder
  8. Di fungsi make_folder menerima parameter jumlah foto yang akan dipindah, kemudian saya declare variable local yang bernama folder dimana ini adalah variable string sebagai nama folder dengan format penamaan folder : folder_1, folder_2, dst
  9. Kemudian dilakukan perulangan untuk memindahkan foto yang ada ke dalam folder tersebut
  10. Di poin a juga dibutuhkan download gambar 10 kali apabila jam menunjukkan 00.00, yang berarti saya harus membuat 1 fungsi lagi yang bernama download_photos_10. 
  11. Di fungsi download_photos_10, saya hanya copy paste dari fungsi download photos karena sama syntaksnya hanya berbeda di jumlah foto yang akan didownload, karena di fungsi ini jumlah downloadnya statis yaitu sudah pasti berjumlah 10 kemudian dipanggillah fungsi make_folder untuk membuat folder
  12. Kemudian saya lanjut mengerjakan poin B karena yang poin A sudah selesai. Di poin B diminta untuk zip folder yang sudah ada, jadi saya melakukan zip dengan deklarasi fungsi otw_zip
  13. Di fungsi otw_zip ini dilakukan pengecekan apakah current hour saat ini bukan jam 12 tengah malam, ini dilakukan agar tidak terjadi tabrakan antara poin B dan poin C nantinya, kemudian di cek apakah tiap folder ada atau available, jika ada maka angka folder akan dipassing ke fungsi create_zip
  14. Di fungsi create_zip akan menerima parameter angka, dimana ini menandakan angka tiap folder. Kemudian akan dilakukan zip untuk tiap folder tanpa menghapus folder tersebut, dimana ini dilakukan dengan format penamaan per zip yaitu ayang_1,ayang_2,dst. Poin pentingnya adalah membuat zip untuk tiap folder dan bukan untuk seluruh folder.
  15. Kemudian saya mulai mengerjakan poin c dimana ini meminta penghapusan seluruh file, disini saya mendeklarasi fungsi delete_zip_n_folder yang menghapus seluruh zip dan folder dengan command rm -rf dan menggunakan perulangan untuk iterasi seluruh folder dan zip
  16. Setelah itu saya mengerjakan poin d, dimana ini diperintahkan untuk download foto eren dan levi secara bergantian. Disini saya menggunakan variable jumlah_character yang mana ini menghitung seluruh file jpg yang ada di dalam folder character, karena saya menggunakan format jpg untuk foto eren dan levi.
  17. Kemudian setelah dihitung, saya modulo dengan 2, apabila saat ini jika jumlah char dimodulo 2 hasilnya 0 maka akan didownload foto levi , jika hasilnya 1 akan download foto eren. Dengan format penamaan `local file_name="${character}_$(date +%Y%m%d).jpg"`
  18. Setelah selesai untuk seluruh fungsi yang dibutuhkan, saatnya saya membuat crontabs untuk menjalan fungsi masing masing sesuai kriteria yang diberikan soal karena waktu tiap fungsi berbeda beda
  19. Saya set untuk fungsi download photos 5 jam sekali, kemudian untuk download photos 10 akan dijalankan tiap 00.00, kemudian ada fungsi download_character_photos yang akan dijalankan tiap hari yaitu pada 00.00, lalu ada fungsi otw_zip yang akan dijalankan tiap 1 jam sekali, dan yang terakhir ada fungsi delete_zip_n_folder yang akan dijalankan tiap jam 2 pagi



**BERIKUT ADALAH CODE FULLNNYA**

```shell
#!/bin/bash

#Global Variable Untuk Current Jam
current_hour=$(date +%H)

#Global Variable untuk jumlah folder
folder_count=$(ls -d /home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/folder_* 2>/dev/null | wc -l)

# Fungsi untuk mendownload gambar Mingyu Seventeen
download_photos() {

    if ((current_hour % 2 == 0)); then
        photo_count=5
    else
        photo_count=3
    fi
    for ((i = 1; i <= $photo_count; i++)); do
        wget -q "https://r2.easyimg.io/uoq79cv09/40cfcaac-4426-4f0f-8731-5a3a2693ca93.png" -O "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/foto_$i.png"
    done

    make_folder $photo_count
}

download_photos_10() {
    photo_count=10
    for ((i = 1; i <= $photo_count; i++)); do
        wget -q "https://r2.easyimg.io/uoq79cv09/40cfcaac-4426-4f0f-8731-5a3a2693ca93.png" -O "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/foto_$i.png"
    done

    make_folder $photo_count

}

make_folder() {

    local photo_count=$1
    local folder="folder_$((++folder_count))"
    mkdir "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/$folder"
    for ((i = 1; i <= $photo_count; i++)); do
        mv "foto_$i.png" "$folder"
    done
}

# Fungsi untuk mendownload gambar Levi atau Eren
download_character_photos() {
    local jumlahCharacter=$(find characters -type f -name "*.jpg" 2>/dev/null | wc -l)
    if [ $(($jumlahCharacter % 2)) -eq 0 ]; then
        character="levi"
    else
        character="eren"
    fi
    local file_name="${character}_$(date +%Y%m%d).jpg"
    if [ "$character" = "levi" ]; then
        wget -q "https://asset.kompas.com/crops/jq91YS0_N1UIQ2Sd5DzlyYOor7Q=/0x83:485x406/750x500/data/photo/2023/11/07/6549ffb04f60a.jpg" -O "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/characters/$file_name"
    elif [ "$character" = "eren" ]; then
        wget -q "https://d1tgyzt3mf06m9.cloudfront.net/v3-staging/2021/03/attack-on-titan-alasan-eren-jadi-villain85457e9a-08f5-454b-acb2-929bcfa31e4c.jpg" -O "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/characters/$file_name"
    fi
}

otw_zip() {
    if [ "$current_hour" != "00" ]; then
        for ((i = 1; i <= $folder_count; i++)); do
            if [ -d "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/folder_$i" ]; then
                create_zip $i
            fi
        done
    fi
}

# Fungsi untuk membuat zip
create_zip() {
    local folder_count=$1
    zip -q -r "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/ayang_$folder_count.zip" "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/folder_$folder_count"
}

delete_zip_n_folder() {

    for ((i = 1; i <= $folder_count; i++)); do
        if [ -d "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/folder_$i" ]; then
            rm -rf "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/folder_$i" "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/ayang_$i.zip"
        fi
    done
}

```

**BERIKUT ADALAH CRONTAB FULLNNYA**
``` shell

* */5 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh download_photos
0 0 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh download_photos_10
0 0 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh download_character_photos
0 * * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh otw_zip

0 2 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh delete_zip_n_folder


```


<br>

**PENJELASAN CODE**


1. `#!/bin/bash`: Ini adalah line yang menunjukkan bahwa script ini harus dijalankan menggunakan bash shell.
   
2. `current_hour=$(date +%H)`: Ini adalah perintah yang menjalankan perintah `date` dengan opsi `%H`, yang akan mengembalikan jam saat ini dalam format 24 jam. Hasilnya ditugaskan ke variabel `current_hour`.

3. `folder_count=$(ls -d /home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/folder_* 2>/dev/null | wc -l)`: Ini menghitung jumlah folder di direktori tertentu dan menetapkannya ke variabel `folder_count`. Ini melakukan ini dengan menggunakan perintah `ls` untuk mencari folder-folder tertentu, meneruskannya ke `wc -l` untuk menghitung jumlah baris output.

4. `download_photos() {`: Ini mendeklarasi sebuah fungsi bernama `download_photos`.

5. `if ((current_hour % 2 == 0)); then`: Ini memulai sebuah statement kondisional. Ini akan mengevaluasi apakah jam saat ini habis dibagi dua tanpa sisa (jam genap).

6. `photo_count=5`: Jika jam saat ini habis dibagi dua, `photo_count` ditetapkan ke 5.

7. `photo_count=3`: Jika jam saat ini tidak habis dibagi dua (jam ganjil), `photo_count` ditetapkan ke 3.

8.  `for ((i = 1; i <= $photo_count; i++)); do`: Ini memulai loop `for` dengan variabel iterasi `i` yang dimulai dari 1 hingga nilai `$photo_count`.

9.  `wget -q "https://r2.easyimg.io/uoq79cv09/40cfcaac-4426-4f0f-8731-5a3a2693ca93.png" -O "/home/oberon/Documents/ITS/MODUL_1/praktikum-modul-1-d27/task-4/foto_$i.png"`: Ini menggunakan perintah `wget` untuk mengunduh gambar dari URL yang ditentukan dan menyimpannya dengan nama file yang sesuai dalam direktori tertentu.

10. `make_folder $photo_count`: Ini memanggil fungsi `make_folder` dan melewatkan jumlah foto sebagai argumen.

11. `download_photos_10() {`: Ini mendeklarasi fungsi `download_photos_10` untuk download photos sebanyak 10 kali.

12. `download_character_photos() {`: Ini mendeklarasi fungsi `download_character_photos` untuk download photos levi dan eren secara bergantian.

13. `otw_zip() {`: Ini mendeklarasi fungsi `otw_zip` untuk inisiasi zip yang melakukan pengecekan avalability untuk tiap folder yang akan di zip kemudian passing variable angka ke `create_zip`.

14. `create_zip() {`: Ini mendeklarasi fungsi `create_zip` membuat zip berdasar angka yang diterima dari fungsi `otw_zip`.

15. `delete_zip_n_folder() {`: Ini mendeklarasi fungsi `delete_zip_n_folder` untuk menghapus zip dan folder.

16. `* */5 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh download_photos`: Ini akan menjalankan skrip `isabel.sh` dengan memanggil fungsi `download_photos` setiap lima jam sekali (pada setiap jam kelipatan 5), setiap hari, setiap minggu, setiap bulan, dan setiap hari dalam seminggu.

17. `0 0 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh download_photos_10`: Ini akan menjalankan skrip `isabel.sh` dengan memanggil fungsi `download_photos_10` setiap pukul 00:00 setiap hari, setiap minggu, setiap bulan, dan setiap hari dalam seminggu.

18. `0 0 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh download_character_photos`: Ini akan menjalankan skrip `isabel.sh` dengan memanggil fungsi `download_character_photos` setiap pukul 00:00 setiap hari, setiap minggu, setiap bulan, dan setiap hari dalam seminggu.

19. `0 * * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh otw_zip`: Ini akan menjalankan skrip `isabel.sh` dengan memanggil fungsi `otw_zip` setiap menit pertama setiap jam, setiap hari, setiap minggu, setiap bulan, dan setiap hari dalam seminggu.

20. `0 2 * * * /home/oberon/Documents/ITS/MODUL_1/praktikum-modul1-d27/task-4/isabel.sh delete_zip_n_folder`: Ini akan menjalankan skrip `isabel.sh` dengan memanggil fungsi `delete_zip_n_folder` setiap pukul 02:00 setiap hari, setiap minggu, setiap bulan, dan setiap hari dalam seminggu.






<br>
<br>

**OUTPUT CODE**




<br>
<br>
<br>
<br>
<br>
<br>