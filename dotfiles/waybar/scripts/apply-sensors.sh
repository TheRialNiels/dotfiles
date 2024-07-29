#!/usr/bin/env bash

for hwmon in /sys/class/hwmon/hwmon*; do
  echo "Directory: $hwmon"
  if [ -f "$hwmon/name" ]; then
    echo "Sensor name: $(cat "$hwmon/name")"
  fi
  for temp in "$hwmon"/temp*_input; do
    if [ -f "$temp" ]; then
      label_file="${temp%_*}_label"
      if [ -f "$label_file" ]; then
        echo "$(cat "$label_file"): $(cat "$temp")"
      else
        echo "Unknown label for $temp: $(cat "$temp")"
      fi
    fi
  done
  echo
done
