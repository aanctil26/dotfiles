#!/bin/bash
# Space plugin - handles active workspace styling

SPACE_ID=$1
CURRENT_SPACE=$(aerospace list-workspaces --focused)

if [ "$SPACE_ID" = "$CURRENT_SPACE" ]; then
  # Active space - show with white square
  sketchybar --set space.$SPACE_ID icon="■" \
                                   icon.color=0xffcdd6f4 \
                                   background.color=0x00000000
else
  # Inactive space - show number
  sketchybar --set space.$SPACE_ID icon="$SPACE_ID" \
                                   icon.color=0xff6c7086 \
                                   background.color=0x00000000
fi