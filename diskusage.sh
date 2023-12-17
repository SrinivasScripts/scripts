#!/bin/bash

# Set threshold value
DISK_THRESHOLD=80
# Function to check disk usage
check_disk() {
    DISK_USAGE=$(df -h / | awk '/\// {print $(NF-1)}' | sed 's/%//')
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo "Disk Usage exceeds $DISK_THRESHOLD%: $DISK_USAGE%" >&2
        exit 1
    fi
}
# Main function
main(){ 
    exec > diskmetrics.txt 2>&1	
    check_disk
    echo "Disk Usage: $DISK_USAGE%" >> diskmetrics.txt
    echo "Metrics collected successfully and stored in disikmetrics.txt"

   }
# Run the main function
main

