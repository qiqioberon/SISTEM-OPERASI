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
