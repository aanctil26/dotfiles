sketchybar --add item battery right                      \
           --set battery script="$PLUGIN_DIR/battery.sh" \
                         icon.font="$FONT:Regular:16.0"  \
                         icon.drawing=on                 \
                         label.drawing=on                \
                         update_freq=10                  \
           --subscribe battery system_woke
