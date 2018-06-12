#!/bin/bash

# headphone detection version 2

while [ true ]
do
    inotifywait -q -e modify "test.txt"
    echo "File updated"
    
done
