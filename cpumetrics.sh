#!/bin/bash
#set -x
# This script monitors CPU and memory usage

# Set thresholds for system metrics
CPU_THRESHOLD=80
MEMORY_THRESHOLD=75
DISK_THRESHOLD=80
# Log file
LOG_FILE="cpumetrics.txt"
services=("ssh" "nginx" "apache2")

# Function to check CPU and memory usage
check_usage() {
  # Get the current usage of CPU and memory
  cpuUsage=$(mpstat 1 1 | awk '/Average:/ { print 100 - $NF}')
  memUsage=$(free -m | awk '/Mem/{print $3}')
  diskUsage=$(df -h / | awk '/\// {print $(NF-1)}' | sed 's/%//')

# Print the usage
  echo "CPU Usage: $cpuUsage%"
  echo "Memory Usage: $memUsage MB"
  echo "DISK USAGE $diskUsage"
  # Check CPU threshold
    if [ -z "$cpuUsage" ] || [ "$cpuUsage" -gt "$CPU_THRESHOLD" ]; then
        echo "ERROR: CPU Usage exceeds $CPU_THRESHOLD%: ${cpuUsage:-N/A}" >> "$LOG_FILE"
        return 1
else
        echo "CPU Usage ${cpuUsage}" >> "$LOG_FILE"
    fi

    # Check memory threshold
    if [ -z "$memUsage" ] || [ "$memUsage" -gt "$MEMORY_THRESHOLD" ]; then
        echo "ERROR: Memory Usage exceeds $MEMORY_THRESHOLD%: ${memUsage:-N/A}" >> "$LOG_FILE"
        return 1
else
        echo "Memory Usage ${memUsage}" >> "$LOG_FILE"
    fi
      # Check disk threshold
    if [ -z "$diskUsage" ] ||["$diskUsage" -gt "$DISK_THRESHOLD"]; then
        echo "Disk Usage exceeds $DISK_THRESHOLD%: $diskUsage%" >> "$LOG_FILE"
        return 1
else
        echo "Disk Usage ${diskUsage}" >> "$LOG_FILE"

    fi
}
# Function to check service status
check_service() {
    local SERVICE=$1

    if [ -z "$SERVICE" ]; then
        echo "Error: No service specified for checking."
        return 1
    fi

    local STATUS=$(systemctl is-active $SERVICE)

    if [ "${STATUS}" = "active" ]; then
        echo "$SERVICE is active."
    else
        echo "$SERVICE is not active."
    fi
}

# Check the status of each service in the list
for service in "${services[@]}"; do
    check_service "$service"
done
extract_logs() {
    LOG_FILE="/var/log/syslog"
    NUM_LINES=10

    # Check if the log file exists
    if [ -f "$LOG_FILE" ]; then
        # If the log file exists, use tail to extract the last NUM_LINES lines
        tail -n "$NUM_LINES" "$LOG_FILE"
    else
        # If the log file doesn't exist, print an error message with a clearer indication of an error
        echo "ERROR: Log file $LOG_FILE not found" >&2
        exit 1
    fi
}
    # Main function
    main() {
    # Redirect standard output and standard error to metrics.txt

        #exec > cpumetrics.txt 2>&1
           # logs=$(extract_logs)
        #echo "Monitoring Script - $(date)" >> "$LOG_FILE"
        #echo "Timestamp: $(date)" >> "$LOG_FILE"
        #echo "$logs" >> "$LOG_FILE"
        check_usage
        check_service
        logs=$(extract_logs)
        echo "Monitoring Script - $(date)" >> "$LOG_FILE"
        #echo "Timestamp: $(date)" >> "$LOG_FILE"
        echo "$logs" >> "$LOG_FILE"


    echo "Metrics collected successfully."
}

# Run the main function
main