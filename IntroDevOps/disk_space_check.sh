#!/bin/bash

# Function to calculate total and free disk space
calculate_disk_space() {
  # Use df command to get disk space details in bytes
  total_space=$(df --block-size=1 --total | grep total | awk '{print $2}')
  free_space=$(df --block-size=1 --total | grep total | awk '{print $4}')

  # Convert bytes to human-readable format
  total_space_human=$(df -h --total | grep total | awk '{print $2}')
  free_space_human=$(df -h --total | grep total | awk '{print $4}')
}

# Function to display disk space details
display_disk_space() {
  echo "Total Disk Space: $total_space_human"
  echo "Free Disk Space: $free_space_human"

  # If "explain" argument is passed, provide detailed explanation
  if [ "$1" == "explain" ]; then
    echo "Explanation:"
    echo "- Total Disk Space represents the total storage capacity of the system."
    echo "- Free Disk Space represents the amount of storage currently available for use."
    echo "- The values are displayed in a human-readable format (e.g., GB, MB)."
  fi
}

# Main script execution
calculate_disk_space
display_disk_space "$1"
