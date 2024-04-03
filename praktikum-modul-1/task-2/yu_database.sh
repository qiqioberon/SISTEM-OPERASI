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
