#!/usr/bin/env sh

source $HOME/.config/sketchybar/icons.sh

# Get current volume percentage and mute status
VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [ "$VOLUME" = "" ]; then
  exit 0
fi

# Check if muted first
if [ "$MUTED" = "true" ]; then
  ICON=$VOLUME_0
  DISPLAY_VOLUME="0"
else
  # Choose icon based on volume level
  case $VOLUME in
    [8-9][0-9]|100) ICON=$VOLUME_100
    ;;
    [5-7][0-9]) ICON=$VOLUME_66
    ;;
    [1-4][0-9]) ICON=$VOLUME_33
    ;;
    [1-9]) ICON=$VOLUME_10
    ;;
    0) ICON=$VOLUME_0
  esac
  DISPLAY_VOLUME="$VOLUME"
fi

sketchybar --set $NAME icon="$ICON" label="${DISPLAY_VOLUME}%"