#!/bin/sh


echo ' * Hostname:' '`'$(cat /proc/sys/kernel/hostname)'`' 
if [ -f /tmp/sysinfo/board_name ] 
then 
  echo '  * Device:' $(cat /tmp/sysinfo/board_name)
else
  echo '  * Device:' $(awk '$1 ~ /vendor_id/ && $3 ~ /AuthenticAMD/ { print "pcengines,alix2" } $1 ~ /vendor_id/ && $0 ~ /Geode by NSC/ { print "soekris,net4826" }' /proc/cpuinfo)
fi 
echo '  * OpenWrt:' $(cat /etc/openwrt_version)
echo '  * IPv4:' $(ip -4 -o addr show dev br-pub | awk '{ print $4 }')
for j in $(brctl show br-pub | awk '{ print $NF }' | grep wlan) ; do 
  echo $j $(iwinfo $j info | awk '$2 ~ /ESSID:/ { print $3 } $0 ~ /Access Point/ { print $3 } $0 ~ /Mode: Master/ { print $4 }')
done | awk '{ print "  * Interface:",$1 ; print "   * SSID:",$2 ; print "   * BSSID:", $3 ; print "   * Channel:",$4 }'
