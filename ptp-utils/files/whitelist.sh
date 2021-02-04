#!/bin/sh

for i in $@ ; do
	grep -i "$i" /tmp/dhcp.leases | awk '{ print "uci add dhcp host ; uci set dhcp.@host[-1].mac=" $2 " ; uci set dhcp.@host[-1].ip=" $3 " ; uci set dhcp.@host[-1].name=" $4 " ; uci commit dhcp ; /usr/nocatauth/bin/access.fw permit " $2, $3, "Member ; echo /usr/nocatauth/bin/access.fw permit " $2, $3, "Member >> /usr/nocatauth/bin/initialize.fw" }'
done
