#!/bin/bash

log_directory="/home/$(whoami)/metrics"

current_date_hour=$(date "+%Y%m%d%H")
backup_file="/home/$(whoami)/metrics/backup_metrics_${current_date_hour}.gz"

cat "$log_directory"/metrics_agg_$(date '+%Y%m%d')*.log | gzip > "$backup_file"

echo "Backup completed. Results saved to $backup_file"
