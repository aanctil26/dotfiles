#!/bin/bash
# Mic plugin

MIC_MUTED=$(osascript -e 'input muted of (get volume settings)')

if [ "$MIC_MUTED" = "true" ]; then
  ICON="􀊲"  # mic.slash
  COLOR=0x88e8eaed
else
  ICON="􀊱"  # mic.fill
  COLOR=0xbfe8eaed
fi

sketchybar --set mic icon="$ICON" icon.color=$COLOR