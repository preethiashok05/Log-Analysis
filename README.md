# Log Monitoring Script

## Overview
This Bash script is designed to monitor a log file in real-time, analyze log entries, and send email alerts based on predefined conditions.

## Prerequisites
- Bash shell environment
- `mail` command to send email alerts (usually available by default on Unix-like systems)
- Proper configuration of email settings to enable email alerts

## Usage
1. **Clone or download** the script file (`log_monitor.sh`) to your local system.
2. **Make the script executable** using the following command:
   ```bash
   chmod +x log_monitor.sh
3. **Run the script** with optional command-line arguments to customize log file path and search keyword:
     ```bash
      ./log_monitor.sh -f /path/to/log/file.log -s "error"
  - -f or --file: Specify the path to the log file (default: "/path/to/log/file.log").
  - -s or --search: Specify the keyword to search for in log entries (default: empty, searches all entries).
4. Once the script is running, it will continuously monitor the specified log file.
5. Press **Ctrl+C** to stop monitoring and display log statistics.

## Testing
- To test the script:

1. **Prepare a sample log file** with various log entries (errors, warnings, info).
2. **Run the script** with the sample log file path.
3. **Generate log entries** in the sample log file to observe the script's behavior:
  - Add new log entries to simulate errors, warnings, and informational messages.
  - Verify that the script properly analyzes and categorizes log entries.
  - Verify that email alerts are sent when the error count exceeds the predefined threshold.

## Example

    ./log_monitor.sh -f sample.log -s "error

## Note

1. **Customize the script** according to your specific log file format and analysis requirements.
2. **Ensure proper permissions and configurations** for email alerts to function correctly.
