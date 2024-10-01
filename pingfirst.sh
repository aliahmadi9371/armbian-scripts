#!/bin/bash

while [! ping -c1 $2 &>/dev/null]
do 
	echo "Ping Fail - `date`" >> $3
	sleep $1
done
echo "Host Found - `date`" >> $3
echo "-------------------------------------------------------------" >> $3
echo "" >> $3
echo "Host Found - `date`"
