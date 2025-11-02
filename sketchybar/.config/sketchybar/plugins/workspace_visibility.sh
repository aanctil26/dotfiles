#!/usr/bin/env sh

# Get current focused workspace and all workspaces with windows
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Hide all workspace items first (1-8)
for i in {1..8}; do
    sketchybar --set space.$i drawing=off
done

# Show workspaces that have windows or are focused (only 1-8)
for sid in {1..8}; do
    WINDOWS_COUNT=$(aerospace list-windows --workspace "$sid" 2>/dev/null | wc -l | tr -d ' ')
    
    # Show if workspace has windows OR is currently focused
    if [ "$WINDOWS_COUNT" -gt 0 ] || [ "$FOCUSED_WORKSPACE" = "$sid" ]; then
        sketchybar --set space.$sid drawing=on
    fi
done

# Handle "+" indicator for workspaces beyond 8
HIGHER_WORKSPACES=$(aerospace list-workspaces --all | awk '$1 > 8 {count++} END {print count+0}')
if [ "$HIGHER_WORKSPACES" -gt 0 ]; then
    sketchybar --set space.plus drawing=on
else
    sketchybar --set space.plus drawing=off
fi