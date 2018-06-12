#!/bin/bash
# This scripts detecs unplugging headphones.

oldstatus="unrelated string"
while [ 1 ]; do
    # The following line has to be changed depending on the difference (use diff) in '/proc/asound/card0/code#0'
    inotifywait -q -e modify '/proc/asound/card0/codec#0' # wait for file to change before doing anything
    status=$(grep -A 4 'Node 0x02' '/proc/asound/card0/codec#0' |  grep 'Amp-Out vals:  \[0x2c 0x2c\]')
    if [ "$status" != "$oldstatus" ]; then
        if [ -n "$status" ]; then
            echo "Plugged in"
            amixer sset Master 48 # Set volume to 80%
            oldstatus="$status"
        else
            echo "Unplugged"
            amixer sset Master 0  # Mute
            oldstatus="$status"
        fi
    fi
done
