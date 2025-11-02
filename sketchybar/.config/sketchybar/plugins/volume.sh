#!/bin/bash
# Volume plugin

VOLUME_OUTPUT=$(osascript -e 'get volume settings')
LEVEL=$(echo "$VOLUME_OUTPUT" | grep -o 'output volume:[0-9]*' | cut -d':' -f2)
MUTED=$(echo "$VOLUME_OUTPUT" | grep -o 'output muted:[a-z]*' | cut -d':' -f2)

if [ "$MUTED" = "true" ] || [ $LEVEL -eq 0 ]; then
  ICON="􀊣"  # speaker.slash
  sketchybar --set volume icon="$ICON" label.drawing=off label.padding_left=0
else
  ICON="􀊥"  # speaker.high
  sketchybar --set volume icon="$ICON" label="$LEVEL%" label.drawing=on label.padding_left=2
fi