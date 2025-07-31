#!/usr/bin/env sh

sketchybar --add item spotify center \
           --set spotify icon="󰓇" \
                         icon.font="Hack Nerd Font Mono:Regular:16.0" \
                         icon.color=0xff1db954 \
                         label.drawing=on \
                         label.max_chars=30 \
                         script="$PLUGIN_DIR/spotify.sh" \
                         click_script="$PLUGIN_DIR/spotify_click.sh" \
                         update_freq=2