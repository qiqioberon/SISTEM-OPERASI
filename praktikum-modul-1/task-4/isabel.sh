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
