#!/bin/bash


#####################################
#
# Script Author: Jamiu
#
# Date: 02-01-2025
#
# Version: v1
#
# Automate Log Analysis
#
#####################################


# Check if the log file path is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

LOG_FILE=$1

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' does not exist."
    exit 1
fi

# Variables
REPORT_FILE="log_summary_report_$(date +%F).txt"
ERROR_KEYWORDS=("ERROR" "Failed")
CRITICAL_KEYWORD="CRITICAL"

echo "Analyzing log file: $LOG_FILE"

# Total lines processed
TOTAL_LINES=$(wc -l < "$LOG_FILE")

# Count errors
ERROR_COUNT=0
for keyword in "${ERROR_KEYWORDS[@]}"; do
    ERROR_COUNT=$((ERROR_COUNT + $(grep -c "$keyword" "$LOG_FILE")))
done

# Identify critical events
CRITICAL_EVENTS=$(grep -n "$CRITICAL_KEYWORD" "$LOG_FILE")

# Extract top 5 error messages
ERROR_MESSAGES=$(grep -E "${ERROR_KEYWORDS[*]}" "$LOG_FILE" | awk '{for(i=2;i<=NF;i++) printf $i " "; print ""}' | sort | uniq -c | sort -nr | head -n 5)

# Generate summary report
echo "Generating summary report: $REPORT_FILE"
echo "Log Analysis Report - $(date)" > "$REPORT_FILE"
echo "Log File: $LOG_FILE" >> "$REPORT_FILE"
echo "Total Lines Processed: $TOTAL_LINES" >> "$REPORT_FILE"
echo "Total Error Count: $ERROR_COUNT" >> "$REPORT_FILE"
echo -e "\nTop 5 Error Messages:" >> "$REPORT_FILE"
echo "$ERROR_MESSAGES" >> "$REPORT_FILE"
echo -e "\nCritical Events (Line Numbers):" >> "$REPORT_FILE"
if [ -z "$CRITICAL_EVENTS" ]; then
    echo "None" >> "$REPORT_FILE"
else
    echo "$CRITICAL_EVENTS" >> "$REPORT_FILE"
fi

# Optional: Archive or move the processed log file
ARCHIVE_DIR="processed_logs"
mkdir -p "$ARCHIVE_DIR"
mv "$LOG_FILE" "$ARCHIVE_DIR/"
echo "Log file moved to $ARCHIVE_DIR/"

echo "Log analysis complete. Report saved to $REPORT_FILE."
exit 0