#!/bin/bash
# CPU click script - opens kitty with btop

# Use kitty with btop
if command -v btop >/dev/null 2>&1; then
    /Applications/kitty.app/Contents/MacOS/kitty --title "System Monitor" btop > /dev/null 2>&1 &
elif command -v htop >/dev/null 2>&1; then
    /Applications/kitty.app/Contents/MacOS/kitty --title "System Monitor" htop > /dev/null 2>&1 &
else
    /Applications/kitty.app/Contents/MacOS/kitty --title "System Monitor" top > /dev/null 2>&1 &
fi