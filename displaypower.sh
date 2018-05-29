#!/bin/bash


while [ true ]; do
    status=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
    if [ "$status" = "on" ]; then
        xbacklight -set 20
    else
        xbacklight -set 8
    fi
done
