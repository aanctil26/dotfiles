#!/usr/bin/env sh

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
                        icon.font="$FONT:Regular:16.0" \
                        icon.drawing=on \
                        label.drawing=on \
                        update_freq=1 \
           --subscribe volume volume_change