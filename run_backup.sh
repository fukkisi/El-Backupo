#!/bin/bash
TODAY=$(date +%d-%m-%Y)
SYSNAME=`hostname`
LOCAL="/mnt/Local"
LOGS="$LOCAL/logs"
    
cd /home/techie
./backup.sh > $LOGS/${SYSNAME}_bash_$TODAY.txt