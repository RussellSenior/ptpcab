#!/bin/sh


echo ' *' $(cat /proc/sys/kernel/hostname) 
if [ -f /tmp/sysinfo/board_name ] 
then 
  echo '  * Device:' $(cat /tmp/sysinfo/board_name)
fi 
echo '  * IPv4:' $(ip -4 -o addr show dev $(uci get network.pub.device) | awk '{ print $4 }')
for j in $(brctl show br-pub | awk '{ print $NF }' | grep wlan) ; do 
  echo $j $(iwinfo $j info | awk '$2 ~ /ESSID:/ { print $3 } $0 ~ /Access Point/ { print $3 } $0 ~ /Mode: Master/ { print $4 }')
done | awk '{ print "  *",$1 ; print "   * SSID:",$2 ; print "   * BSSID:", $3 ; print "   * Channel:",$4 }'

