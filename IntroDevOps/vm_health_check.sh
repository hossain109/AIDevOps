#!/bin/bash

# Function to check CPU usage
check_cpu() {
  # Get CPU idle percentage using top command
  cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
  cpu_usage=$((100 - cpu_idle))
  echo $cpu_usage
}

# Function to check memory usage
check_memory() {
  # Get memory usage using free command
  memory_total=$(free | grep Mem | awk '{print $2}')
  memory_used=$(free | grep Mem | awk '{print $3}')
  memory_usage=$((memory_used * 100 / memory_total))
  echo $memory_usage
}

# Function to check disk usage
check_disk() {
  # Get disk usage using df command
  disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
  echo $disk_usage
}

# Main health check function
health_check() {
  cpu=$(check_cpu)
  memory=$(check_memory)
  disk=$(check_disk)

  # Check if any parameter exceeds 60%
  if [ $cpu -gt 60 ] || [ $memory -gt 60 ] || [ $disk -gt 60 ]; then
    status="Not Healthy"
  else
    status="Healthy"
  fi

  # Print health status
  echo "VM Status: $status"

  # If "explain" argument is passed, provide reasons
  if [ "$1" == "explain" ]; then
    echo "Detailed Analysis:"
    if [ $cpu -gt 60 ]; then
      echo "- CPU usage is too high: $cpu%"
    else
      echo "- CPU usage is within limits: $cpu%"
    fi

    if [ $memory -gt 60 ]; then
      echo "- Memory usage is too high: $memory%"
    else
      echo "- Memory usage is within limits: $memory%"
    fi

    if [ $disk -gt 60 ]; then
      echo "- Disk usage is too high: $disk%"
    else
      echo "- Disk usage is within limits: $disk%"
    fi
  fi
}

# Run health check
health_check "$1"
