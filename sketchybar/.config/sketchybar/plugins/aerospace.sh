#!/usr/bin/env sh

# Get the workspace ID from the argument
WORKSPACE_ID="$1"

# Get the currently focused workspace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Check if workspace has windows
WINDOWS_COUNT=$(aerospace list-windows --workspace "$WORKSPACE_ID" 2>/dev/null | wc -l | tr -d ' ')

if [ "$FOCUSED_WORKSPACE" = "$WORKSPACE_ID" ]; then
    # This is the focused workspace
    sketchybar --set space.$WORKSPACE_ID background.drawing=on \
                                        background.color=0x44ffffff \
                                        icon.color=0xff000000
else
    # Not the focused workspace
    if [ "$WINDOWS_COUNT" -gt 0 ]; then
        # Has windows - show as occupied but not focused
        sketchybar --set space.$WORKSPACE_ID background.drawing=off \
                                            icon.color=0xffffffff
    else
        # Empty workspace - show dimmed
        sketchybar --set space.$WORKSPACE_ID background.drawing=off \
                                            icon.color=0x88ffffff
    fi
fi