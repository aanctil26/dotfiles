sketchybar --add item battery right                      \
           --set battery script="$PLUGIN_DIR/battery.sh" \
                         icon.font="$NERD_FONT:Bold:14.0" \
                         icon.color=0xffa3be8c            \
                         icon.drawing=on                 \
                         label.font="$FONT:Medium:13.0"   \
                         label.color=0xffd8dee9           \
                         label.drawing=on                \
                         background.color=0x443b4252     \
                         background.corner_radius=8      \
                         background.height=26            \
                         background.drawing=on           \
                         update_freq=10                  \
           --subscribe battery system_woke
