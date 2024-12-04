#!/bin/sh
while [ 1 ]
do
        if [ `date | awk '{print $4}' | cut -c 7-8` == "00" ]
        then
        		mkdir -p established
        		established=`netstat -na | grep 48080 | grep ESTABLISHED | wc -l`
        		minute=`date | awk '{print $4}'`
        		day=`date '+%Y-%m-%d'`
        		echo "$day $minute $established" >> /established/"$day".log
        fi
        sleep 1

done