#!/bin/bash
# Display change listener - triggers clock repositioning and battery update

# Trigger clock update to reposition based on display count
sketchybar --trigger clock_update

# Trigger battery update to check charging state
sketchybar --trigger battery_update