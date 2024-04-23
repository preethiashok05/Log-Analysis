#!/bin/bash

# Default configuration
LOG_FILE="/path/to/log/file.log"
SEARCH_KEYWORD=""
EMAIL_ALERT_THRESHOLD=10
EMAIL_RECIPIENT="user@example.com"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -f|--file)
        LOG_FILE="$2"
        shift
        shift
        ;;
        -s|--search)
        SEARCH_KEYWORD="$2"
        shift
        shift
        ;;
        *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

# Function to display new log entries
monitor_log() {
    tail -n 0 -F "$LOG_FILE" | while read line ; do
        echo "$(date +"%Y-%m-%d %T") $line"
        analyze_log_entry "$line"
    done
}

# Function to analyze log entries
analyze_log_entry() {
    local entry="$1"
    # Example analysis: Count occurrences of different log levels
    if grep -qi "error" <<<"$entry"; then
        ((ERROR_COUNT++))
        check_error_threshold "$ERROR_COUNT"
    elif grep -qi "warning" <<<"$entry"; then
        ((WARNING_COUNT++))
    elif grep -qi "info" <<<"$entry"; then
        ((INFO_COUNT++))
    fi
}

# Function to check if error count exceeds the threshold
check_error_threshold() {
    local error_count="$1"
    if [ "$error_count" -ge "$EMAIL_ALERT_THRESHOLD" ]; then
        send_email_alert "High number of errors detected!"
    fi
}

# Function to send email alert
send_email_alert() {
    local message="$1"
    echo "$message" | mail -s "Log Alert" "$EMAIL_RECIPIENT"
}

# Function to search for specific keywords in log entries
search_log() {
    local keyword="$1"
    grep -i "$keyword" "$LOG_FILE"
}

# Function to display log statistics
display_statistics() {
    echo "Log Statistics:"
    echo "----------------"
    echo "Total Errors: $ERROR_COUNT"
    echo "Total Warnings: $WARNING_COUNT"
    echo "Total Info: $INFO_COUNT"
}

# Function to stop monitoring
stop_monitoring() {
    echo "Stopping log monitoring..."
    display_statistics
    exit 0
}

# Trap SIGINT (Ctrl+C) to stop monitoring
trap stop_monitoring SIGINT

# Initialize log statistics counters
ERROR_COUNT=0
WARNING_COUNT=0
INFO_COUNT=0

# Start monitoring the log file
monitor_log
