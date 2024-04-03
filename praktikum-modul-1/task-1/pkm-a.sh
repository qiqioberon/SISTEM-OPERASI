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
