#!/bin/bash
# Bluetooth plugin

BT_STATUS=$(system_profiler SPBluetoothDataType | grep -c "State: On")

if [ $BT_STATUS -eq 1 ]; then
  ICON="􀉨"  # bluetooth
  COLOR=0xbfe8eaed
else
  ICON="􀙇"  # bluetooth.slash (using wifi.slash as substitute)
  COLOR=0x88e8eaed
fi

sketchybar --set bluetooth icon="$ICON" icon.color=$COLOR