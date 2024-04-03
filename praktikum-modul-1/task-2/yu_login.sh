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
