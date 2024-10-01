/etc/init.d/ntp stop
ntpdate 192.168.180.74
hwclock -f /dev/rtc1 -w