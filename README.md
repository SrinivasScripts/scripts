# System Monitoring Script

This Bash script monitors CPU, memory, disk usage, and the status of specified services. It logs relevant information to a file and can be used for system health monitoring.

## Usage

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/SrinivasScripts/scripts.git
   cd your-repository

Make the Script Executable:
chmod +x cpumetrics.sh

Run the Script:
./cpumetrics.sh

Configuration
Tailor the script to your specific needs by adjusting the following threshold parameters:
# Set thresholds for system metrics
CPU_THRESHOLD=80
MEMORY_THRESHOLD=75
DISK_THRESHOLD=80
Configuration
Tailor the script to your specific needs by adjusting the following threshold parameters

Features
Monitors CPU, memory, and disk usage.
Checks the status of specified services (e.g., SSH, Nginx, Apache2).
Logs information to a file (cpumetrics.txt by default).
Retrieves and logs system logs for troubleshooting.

Log File
The script generates a log file (cpumetrics.txt) containing detailed information on CPU usage, memory consumption, disk utilization, service statuses, and system logs.

To review the last 10 lines of the log file:

tail -n 10 cpumetrics.txt

Customization
Service Monitoring
Customize the list of monitored services by modifying the services array in the script:
services=("ssh" "nginx" "apache2")
Add or remove services to align with your specific environment.

Log Extraction
Adjust the NUM_LINES variable in the extract_logs function to specify the number of lines extracted from system logs:
NUM_LINES=10

License
This script is licensed under the MIT License - refer to the LICENSE file for details.

Feel free to copy and paste this content into your README.md file.
