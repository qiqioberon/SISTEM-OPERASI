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
