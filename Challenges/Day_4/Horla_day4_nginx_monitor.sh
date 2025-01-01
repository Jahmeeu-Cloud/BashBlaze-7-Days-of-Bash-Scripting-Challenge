#!/bin/bash

#####################################
#
# Script Author: Jamiu
#
# Date: 01-01-2025
#
# Version: v1
#
# Nginx Monitor
#
#####################################

# Script to monitor a process and restart if not running.
# Usage: ./monitor_process.sh <process_name>

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <process_name>"
  exit 1
fi

PROCESS_NAME=$1
MAX_ATTEMPTS=3
ATTEMPT=0

while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
  # Check if the process is running
  if pgrep -x "$PROCESS_NAME" > /dev/null; then
    echo "Process $PROCESS_NAME is running."
    exit 0
  else
    echo "Process $PROCESS_NAME is not running. Attempting to restart..."

    # Attempt to restart the process
    if command -v systemctl &> /dev/null; then
      sudo systemctl restart $PROCESS_NAME
    elif command -v service &> /dev/null; then
      sudo service $PROCESS_NAME restart
    else
      echo "No suitable command found to manage the service. Please check your init system."
      exit 1
    fi

    sleep 2
  fi

  # Check again if the process is running after restart attempt
  if pgrep -x "$PROCESS_NAME" > /dev/null; then
    echo "Process $PROCESS_NAME restarted successfully."
    exit 0
  fi

  ATTEMPT=$((ATTEMPT + 1))
done

echo "Maximum restart attempts reached. Please check the process manually."