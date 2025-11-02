#!/usr/bin/env sh

# Get list of existing workspaces
EXISTING_WORKSPACES=$(aerospace list-workspaces --all)

# Hide all workspace items first
for i in {1..10}; do
    sketchybar --set space.$i drawing=off
done
sketchybar --set space.plus drawing=off

# Show only existing workspaces (up to 8)
COUNT=0
for workspace in $EXISTING_WORKSPACES; do
    if [ $COUNT -lt 8 ]; then
        sketchybar --set space.$workspace drawing=on
        COUNT=$((COUNT + 1))
    fi
done

# Show "+" if there are more than 8 workspaces
TOTAL_COUNT=$(echo "$EXISTING_WORKSPACES" | wc -w | tr -d ' ')
if [ "$TOTAL_COUNT" -gt 8 ]; then
    sketchybar --set space.plus drawing=on
fi