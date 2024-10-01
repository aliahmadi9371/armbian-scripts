#!/bin/bash
sleep 10
while true; do
	cd /opt/Access-V1-0-0/bin
	sudo ntpdate 192.168.137.1
	sleep 10
	sudo /opt/Access-V1-0-0/bin/Access-V1-0-0
	sleep 1
done
