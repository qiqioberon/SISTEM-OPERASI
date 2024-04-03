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
