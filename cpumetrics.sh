#!/bin/bash
#set -x
# This script monitors CPU and memory usage

# Set thresholds for system metrics
CPU_THRESHOLD=80
MEMORY_THRESHOLD=75
DISK_THRESHOLD=80
# Log file
LOG_FILE="cpumetrics.txt"

# Function to check CPU and memory usage
check_usage() {
  # Get the current usage of CPU and memory
  cpuUsage=$(mpstat 1 1 | awk '/Average:/ { print 100 - $NF}')
  memUsage=$(free -m | awk '/Mem/{print $3}')
  DISK_USAGE=$(df -h / | awk '/\// {print $(NF-1)}' | sed 's/%//')
  # Print the usage
  echo "CPU Usage: $cpuUsage%"
  echo "Memory Usage: $memUsage MB"
  echo "DISK USAGEL $DISK_USAGE MB"
  # Check CPU threshold
    if [ -z "$cpuUsage" ] || [ "$cpuUsage" -gt "$CPU_THRESHOLD" ]; then
        echo "ERROR: CPU Usage exceeds $CPU_THRESHOLD%: ${cpuUsage:-N/A}" >> "$LOG_FILE"
        return 1
    fi

    # Check memory threshold
    if [ -z "$memUsage" ] || [ "$memUsage" -gt "$MEMORY_THRESHOLD" ]; then
        echo "ERROR: Memory Usage exceeds $MEMORY_THRESHOLD%: ${memUsage:-N/A}" >> "$LOG_FILE"
        return 1
    fi
      # Check disk threshold
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo "Disk Usage exceeds $DISK_THRESHOLD%: $DISK_USAGE%" >> "$LOG_FILE"
        return 1
    fi
}
# Function to check service status
check_service() {
    local SERVICE=$1
    if [ -z "$SERVICE" ]; then
        echo "Error: No service specified for checking."
        return 1
    fi

    local STATUS="$(systemctl is-active $SERVICE)"

    if [ "${STATUS}" = "active" ]; then
        echo "$(date) - $SERVICE Service is Active" >> "$LOG_FILE"
    else
        echo "$(date) - ERROR: $SERVICE Service not Active" >> "$LOG_FILE"
        return 1
    fi
}
    # Main function
    main() {
    # Redirect standard output and standard error to metrics.txt

        #exec > cpumetrics.txt 2>&1
	echo "Monitoring Script - $(date)" > "$LOG_FILE"
        echo "Timestamp: $(date)"
        check_usage
	check_service "plymouth"
   

    echo "Metrics collected successfully."
}

# Run the main function
main

