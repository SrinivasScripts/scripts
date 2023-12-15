#!/bin/bash
# This script monitors CPU and memory usage

# Set thresholds for system metrics
CPU_THRESHOLD=80
MEMORY_THRESHOLD=75
# Function to check CPU and memory usage
check_usage() {
  # Get the current usage of CPU and memory
  cpuUsage=$(mpstat 1 1 | awk '/Average:/ { print 100 - $NF}')
  memUsage=$(free -m | awk '/Mem/{print $3}')

  # Print the usage
  echo "CPU Usage: $cpuUsage%"
  echo "Memory Usage: $memUsage MB"

  # Check CPU threshold
    if [ -z "$cpuUsage" ] || [ "$cpuUsage" -gt "$CPU_THRESHOLD" ]; then
        echo "ERROR: CPU Usage exceeds $CPU_THRESHOLD%: ${cpuUsage:-N/A}" >&2
        exit 1
    fi

    # Check memory threshold
    if [ -z "$memUsage" ] || [ "$memUsage" -gt "$MEMORY_THRESHOLD" ]; then
        echo "ERROR: Memory Usage exceeds $MEMORY_THRESHOLD%: ${memUsage:-N/A}" >&2
        exit 1
    fi
}
    # Main function
    main() {
    # Redirect standard output and standard error to metrics.txt

        exec > cpumetrics.txt 2>&1
    echo "Timestamp: $(date)"
    check_usage
   

    echo "Metrics collected successfully."
}

# Run the main function
main

