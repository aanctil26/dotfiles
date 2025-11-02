#!/bin/bash
# WiFi plugin

# Check if WiFi interface has an IP address (means connected)
WIFI_IP=$(ifconfig en0 | grep "inet " | awk '{print $2}')

if [[ $WIFI_IP = "" ]]; then
  ICON="􀙈"  # wifi.slash
  COLOR=0x88e8eaed
else
  ICON="􀙇"  # wifi
  COLOR=0xd9e8eaed
fi

sketchybar --set wifi icon="$ICON" icon.color=$COLOR

