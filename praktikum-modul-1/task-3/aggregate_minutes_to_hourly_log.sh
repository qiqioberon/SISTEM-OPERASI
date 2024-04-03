#!/bin/bash

log_directory="/home/$(whoami)/metrics"
aggregation_file="/home/$(whoami)/metrics/metrics_agg_$(date '+%Y%m%d%H').log"

declare -A min_values max_values sum_values count_values
metrics=("mem_total" "mem_used" "mem_free" "mem_shared" "mem_buff_cache" "mem_available" "swap_total" "swap_used" "swap_free")

for metric in "${metrics[@]}"; do
    min_values[$metric]=999999999
    max_values[$metric]=0
    sum_values[$metric]=0
    count_values[$metric]=0
done

# Proses file log
for log_file in $log_directory/metrics_$(date '+%Y%m%d%H')*.log; do
    while IFS= read -r line; do
        if [[ $line == Mem:* ]]; then
            read -r _ mem_total mem_used mem_free mem_shared mem_buff_cache mem_available <<< "$line"
            metrics_values=($mem_total $mem_used $mem_free $mem_shared $mem_buff_cache $mem_available)
        elif [[ $line == Swap:* ]]; then
            read -r _ swap_total swap_used swap_free <<< "$line"
            metrics_values+=($swap_total $swap_used $swap_free)
        fi
    done < "$log_file"

    for i in "${!metrics[@]}"; do
        metric=${metrics[$i]}
        value=${metrics_values[$i]}
            
        [[ $value -lt ${min_values[$metric]} ]] && min_values[$metric]=$value
        [[ $value -gt ${max_values[$metric]} ]] && max_values[$metric]=$value
        sum_values[$metric]=$(( ${sum_values[$metric]} + value ))
        count_values[$metric]=$(( ${count_values[$metric]} + 1 ))
    done
done

{
    printf "\t\tMem_total\tMem_used\tMem_free\tMem_shared\tMem_buff\tMem_available\tSwap_total\tswap_used\tswap_free\n"
    printf "Minimum:\t"
    for metric in "${metrics[@]}"; do
        printf "%s\t\t" "${min_values[$metric]}"
    done
    printf "\n"
    
    printf "Maximum:\t"
    for metric in "${metrics[@]}"; do
        printf "%s\t\t" "${max_values[$metric]}"
    done
    printf "\n"
    
    printf "Average:\t"
    for metric in "${metrics[@]}"; do
        if [[ "${count_values[$metric]}" -gt 0 ]]; then
            average=$(bc <<< "scale=2; ${sum_values[$metric]} / ${count_values[$metric]}")
        else
            average=0
        fi
        printf "%s\t\t" "$average"
    done
    printf "\n"
} > "$aggregation_file"

echo "Aggregation completed. Results saved to $aggregation_file"
