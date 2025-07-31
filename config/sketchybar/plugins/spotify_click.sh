#!/usr/bin/env sh

# Toggle play/pause when clicked
osascript -e '
    tell application "Spotify"
        if it is running then
            if player state is playing then
                pause
            else
                play
            end if
        else
            activate
        end if
    end tell
' 2>/dev/null