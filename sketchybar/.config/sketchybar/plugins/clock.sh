#!/bin/bash
# Clock plugin - shows "Wednesday 21:27" format

TIME=$(date '+%A %I:%M %p')

# Faster display detection using displayplacer
DISPLAY_COUNT=$(system_profiler SPDisplaysDataType 2>/dev/null | grep -c "Resolution:" || echo "1")

# Get current position to avoid unnecessary moves
CURRENT_POS=$(sketchybar --query clock 2>/dev/null | grep -o '"position": "[^"]*"' | cut -d'"' -f4)

if [ "$DISPLAY_COUNT" -eq 1 ]; then
    # Only built-in display - should be on left
    if [ "$CURRENT_POS" != "left" ]; then
        sketchybar --move clock left
    fi
else
    # Multiple displays (docked) - should be in center
    if [ "$CURRENT_POS" != "center" ]; then
        sketchybar --move clock center
    fi
fi

sketchybar --set clock label="$TIME"
