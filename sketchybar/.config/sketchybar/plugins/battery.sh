#!/bin/bash
# Battery plugin with icon and percentage

BATTERY_INFO=$(pmset -g batt | grep -E "([0-9]+\%).*" -o)
PERCENTAGE=$(echo $BATTERY_INFO | grep -o '[0-9]*%' | cut -d'%' -f1)
CHARGING=$(echo $BATTERY_INFO | grep -c " charging")
CHARGED=$(echo $BATTERY_INFO | grep -c "charged")

# Choose icon based on level and charging state
if [ $CHARGING -eq 1 ]; then
  ICON="􀢋"  # battery.100.bolt (only when actively charging)
elif [ $PERCENTAGE -gt 75 ]; then
  ICON="􀛨"  # battery.full
elif [ $PERCENTAGE -gt 50 ]; then
  ICON="􀺸"  # battery.50
elif [ $PERCENTAGE -gt 25 ]; then
  ICON="􀺶"  # battery.25
else
  ICON="􀛩"  # battery.0
fi

# Choose color based on level
if [ $PERCENTAGE -le 10 ]; then
  COLOR=0xffEF5350  # critical
elif [ $PERCENTAGE -le 20 ]; then
  COLOR=0xffF9A825  # warning
else
  COLOR=0xe6e8eaed  # normal
fi

sketchybar --set battery icon="$ICON" \
                        icon.color=$COLOR \
                        label="$PERCENTAGE%" \
                        label.color=$COLOR
