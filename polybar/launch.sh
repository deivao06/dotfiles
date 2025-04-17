#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)

# Launch bar
for monitor in $MONITORS; do
    MONITOR=$monitor polybar dvd 2>&1 | tee -a /tmp/polybar-$monitor.log & disown
done

echo "Bars launched..."
