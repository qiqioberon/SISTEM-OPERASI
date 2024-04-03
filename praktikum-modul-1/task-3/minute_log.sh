#!/bin/bash

ram_metrics=$(free -m)

target_path="/home/$(whoami)/"
dir_size=$(du -sh "$target_path")

log_dir="/home/$(whoami)/metrics"
log_file="$log_dir/metrics_${date "+%Y%m%d%H%M%S"}.log"

mkdir -p "$log_dir"

echo "RAM Metrics:" >> "$log_file"
echo "$ram_metrics" >> "$log_file"
echo "" >> "$log_file"
echo "Directory Size Metrics for $target_path:" >> "$log_file"
echo "$dir_size" >> "$log_file"
