#!/usr/bin/env sh

# Get the workspace ID from the argument
WORKSPACE_ID="$1"

# Get the currently focused workspace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Check if workspace has windows
WINDOWS_COUNT=$(aerospace list-windows --workspace "$WORKSPACE_ID" 2>/dev/null | wc -l | tr -d ' ')

# Update workspace styling and visibility
if [ "$WINDOWS_COUNT" -gt 0 ] || [ "$FOCUSED_WORKSPACE" = "$WORKSPACE_ID" ]; then
    # Show this workspace
    sketchybar --set space.$WORKSPACE_ID drawing=on
    
    if [ "$FOCUSED_WORKSPACE" = "$WORKSPACE_ID" ]; then
        # This is the focused workspace
        sketchybar --set space.$WORKSPACE_ID background.drawing=on \
                                            background.color=0x44ffffff \
                                            icon.color=0xff000000
    else
        # Has windows but not focused
        sketchybar --set space.$WORKSPACE_ID background.drawing=off \
                                            icon.color=0xffffffff
    fi
else
    # Empty workspace - hide it completely
    sketchybar --set space.$WORKSPACE_ID drawing=off
fi