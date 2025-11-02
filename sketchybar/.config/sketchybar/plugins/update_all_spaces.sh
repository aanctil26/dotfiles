#!/bin/bash
# Update all workspace indicators

for i in {1..10}; do
  /Users/andrew/.config/sketchybar/plugins/space.sh $i &
done
wait