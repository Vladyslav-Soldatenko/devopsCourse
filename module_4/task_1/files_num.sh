#!/bin/bash

if [[ $# -le 0 ]] # if no arguments
    then 
        printf "No arguments was passed\n "
        exit 1
fi

if [[ ! -d "$1" ]]
then
    printf "passed argument is not a dir"
fi

dpath="$1"

echo "$dpath is directory."

cf=$(find "$dpath" -type f | wc -l)

echo "Total number of files: $cf"
