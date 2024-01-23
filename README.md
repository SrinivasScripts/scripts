# System Monitoring Script

## Overview

This Bash script is designed to monitor key system metrics, including CPU, memory, and disk usage, as well as the status of specified services. The script aims to provide users with a flexible and easy-to-use solution for customizing monitoring thresholds and obtaining insightful log outputs.

## STAR Analysis

### Situation
- Efficient system monitoring is crucial for maintaining optimal system performance.
- Existing monitoring tools may lack the flexibility needed for specific use cases.

### Task
- Develop a Bash script (`monitor_script.sh`) to address the need for customizable system monitoring.
- Create a user-friendly and configurable script to monitor CPU, memory, disk usage, and specific services.

### Action
- Implemented the script to monitor CPU, memory, and disk usage thresholds.
- Included service status checks for user-specified services.
- Enhanced logging for detailed tracking and analysis.

### Result
- Users can easily clone the repository, customize monitoring thresholds, and execute the script to monitor their system effectively.
- The script generates informative log files (`cpumetrics.txt`) for streamlined issue identification.

## SWOT Analysis

### Strengths
- **Configurability:** Easily adjust threshold values for CPU, memory, and disk usage.
- **User-friendly:** Clear usage instructions and detailed log outputs.
- **Open Source:** Freely available for contributions and improvements.

### Weaknesses
- **Single Platform:** Currently designed for Linux systems.
- **Dependency on System Tools:** Relies on tools like `systemctl`, which may not be universally available.

### Opportunities
- **Community Contribution:** Encourage contributions and feedback for continuous improvement.
- **Cross-Platform Support:** Explore options for compatibility with various operating systems.

### Threats
- **System Changes:** Future Linux system updates may impact script functionality.
- **Security Concerns:** Users should review and understand the script's actions for potential security implications.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/SrinivasScripts/system-monitor-script.git
