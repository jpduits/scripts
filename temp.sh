#!/bin/bash

function get_temp() {
    echo -n "Current temperatures @"
    date +"%T"
    sensors | grep 'CPU\|GPU'
}

function loop() {        
while :
do
       
       get_temp
       echo "Press CTRL+c to stop. Refreshes every $1 seconds"
       sleep $1
       clear
done
}


#===================================
# $# = number of arguments
if [ $# -eq 0 ]
then
  get_temp
  exit 0
fi


while getopts 'hl:' OPTION; do
    case $OPTION in
        h)
            echo "Usage:"
            echo "  -h  help (this screen)"
            echo "  -l  loop"

            exit 0
            ;;
        l)
            interval=$OPTARG
            if expr "$interval" : '-\?[0-9]\+$' >/dev/null
            then
                echo "Set interval to $interval seconds"
            else
                echo "Interval not valid, interval set to 20 seconds"
                interval=20
            fi
            loop $interval
            ;;
    esac
done    


