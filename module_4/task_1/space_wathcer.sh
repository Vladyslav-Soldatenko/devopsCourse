#!/bin/bash
# script requires to provide threshhold as percents
declare THERSHOLD=25

if [[ $# -le 0 ]] # if no arguments
    then printf "No arguments was passed, using default threshhold %s \n " "$THERSHOLD"
else
 if [[ "$1" =~ ^[0-9]+$ &&  $1 -ge 0 && $1 -le 100 ]] # check if integer 0 <= input <=100
    then
     THERSHOLD=$1
     printf "threshhold was passed, %s \n" "$THERSHOLD"
     else
        printf "pass an integer between 0 and 100 \n"
    fi
fi

while true 
do
    USED_SPACE_PERCENTAGE=$(df / | tail -n 1 | awk '{print $5}') # ex 15%
    declare -i USED_SPACE_NUMBER=${USED_SPACE_PERCENTAGE/\%}
    declare -i DISC_FREE_SPACE=$((100 - USED_SPACE_NUMBER))
    if [[ DISC_FREE_SPACE -lt THERSHOLD ]]
        then
            printf "disc free space is below threshhold: %d\n" "$DISC_FREE_SPACE"
        else
            printf "disc free space is fine, current free space is %d\n" "$DISC_FREE_SPACE"
    fi
    sleep 5
done
