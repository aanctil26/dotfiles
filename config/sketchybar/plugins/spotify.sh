#!/usr/bin/env sh

# Check if external monitor is connected
EXTERNAL_MONITOR=$(system_profiler SPDisplaysDataType | grep -c "Resolution:" | awk '{if($1 > 1) print "true"; else print "false"}')

# Get current Spotify track info using AppleScript
TRACK_INFO=$(osascript -e '
    tell application "Spotify"
        if it is running then
            if player state is playing then
                set track_name to name of current track
                set artist_name to artist of current track
                return track_name & " - " & artist_name
            else if player state is paused then
                return "⏸ Paused"
            else
                return ""
            end if
        else
            return ""
        end if
    end tell
' 2>/dev/null)

# Check if Spotify is running and has track info
if [ -z "$TRACK_INFO" ] || [ "$TRACK_INFO" = "" ]; then
    # Hide the item when Spotify is not playing
    sketchybar --set $NAME drawing=off
else
    # Adjust position based on monitor setup
    if [ "$EXTERNAL_MONITOR" = "true" ]; then
        # External monitor connected - keep in center
        sketchybar --set $NAME position=center drawing=on label="$TRACK_INFO"
    else
        # No external monitor - move to right group as leftmost item
        sketchybar --set $NAME position=right drawing=on label="$TRACK_INFO"
        sketchybar --move $NAME before clock
    fi
fi
