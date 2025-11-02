#!/usr/bin/env sh

sketchybar --add item        cpu.percent right             \
           --set cpu.percent label.font="$FONT:Bold:12"   \
                             label=CPU                     \
                             width=40                      \
                             icon.drawing=off              \
                             update_freq=2                 \
                             background.padding_right=10   \
                                                           \
           --add graph       cpu.sys right 100             \
           --set cpu.sys     width=50                      \
                             graph.color=$RED              \
                             graph.fill_color=$RED         \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_right=5    \
                                                           \
           --add graph       cpu.user right 100            \
           --set cpu.user    graph.color=$BLUE             \
                             width=50                      \
                             update_freq=2                 \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_right=10   \
                             script="$PLUGIN_DIR/cpu.sh"
