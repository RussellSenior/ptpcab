#!/bin/sh
mac=$2
# clear client database
rm -rf /tmp/clients-last
mv /tmp/clients /tmp/clients-last

# remember starting directory
wd=$(pwd)

# construct client database from radio information
find /sys/kernel/debug/ieee80211/ -type d | grep stations | awk -F/ 'NF == 9 { split($7,a,":") ; print $6,a[2],$9 }' | while read phy wif bssid ; do
	mkdir -p /tmp/clients/$bssid
	cd /tmp/clients/$bssid
	echo $wif > wif
	echo $phy > phy
	iwinfo $(cat wif) assoc | grep -A2 -i "$bssid" | tr -d '(),' | awk '
		NR == 1 { print $2 > "rssi" ; print $5 > "noise" ; print $8 > "snr" ; print $9 > "last_rx" }
		NR == 2 && $4 ~ /MCS/ { print $2 > "rx_rate"; print $5 > "rx_mcs" ; print $6 > "rx_chanwidth" ; print $7 > "rx_packets" }
		NR == 2 && NF == 5 { print $2 > "rx_rate" ; print $4 > "rx_packets" }
		NR == 3 && $4 ~ /MCS/ { print $2 > "tx_rate"; print $5 > "tx_mcs" ; print $6 > "tx_chanwidth" ; print $7 > "tx_packets" }
		NR == 3 && NF == 5 { print $2 > "tx_rate" ; print $4 > "tx_packets" }'
	cd $wd
done

# construct client database from dhcp lease information
cat /tmp/dhcp.leases | while read lease_time mac ipv4 hostname mumble ; do
	if [ ! -d /tmp/clients/$mac ] ; then
		mkdir -p /tmp/clients/$mac
	fi
	cd /tmp/clients/$mac
	echo "$lease_time" > lease_time
	echo "$ipv4" > ipv4
	echo "$hostname" > hostname
	ln -s /tmp/clients/$mac /tmp/clients/$ipv4
done

# construct client database from iptables mangle table information
/usr/sbin/iptables -t mangle -nvxL NoCat | grep MAC | while read packets_out bytes_out table j0 j1 j2 j3 ipv4 j4 j5 mac j6 j7 mark ; do
	mac=$(echo $mac | tr 'A-F' 'a-f')
	if [ ! -d /tmp/clients/$mac ] ; then
                mkdir -p /tmp/clients/$mac
        fi
	cd /tmp/clients/$mac
	echo "$packets_out" > packets_out
	echo "$bytes_out" > bytes_out
	echo "$ipv4" > ipv4_mangle
	echo "$mark" > mark
	if [ ! -e /tmp/clients/$ipv4 ] ; then
		ln -s /tmp/clients/$mac /tmp/clients/$ipv4
	fi
done

# construct client database from iptables filter table information
/usr/sbin/iptables -nvxL NoCat_Inbound | grep ACCEPT | while read packets_in bytes_in j0 j1 j2 j3 j4 j5 ipv4 ; do
	cd /tmp/clients/$ipv4
	echo "$packets_in" > packets_in
	echo "$bytes_in" > bytes_in
done

cd $wd

# print rows of (macaddr,ipaddr,bytes)
ncusers()
{
for i in $(find /tmp/clients -name ipv4_mangle) ; do echo $(echo $i | cut -d/ -f4) $(cat $i) $(cat ${i%%ipv4_mangle}bytes_out) ; done
}

# prints number of clients auth'd
usercount()
{
find /tmp/clients -name ipv4_mangle | wc -l
}

# prints rows of people connected (macaddr,ipaddr,bytes,rssi)
cmb() 
{
for i in $(find /tmp/clients -name ipv4_mangle) ; do echo $(echo $i | cut -d/ -f4) $(cat $i) $(cat ${i%%ipv4_mangle}bytes_out) $(cat ${i%%ipv4_mangle}rssi) ; done
}

sta2()
{
#cmb | sort -r | uniq -w17 | awk '{print $3,$1,$2,$4}' | sort -nr | awk '{print $2,$3,$1,$4}'| sed 's/\(.*\) \(.*\) \(.*\) \(.*\)/\&mac=\1\&ip=\2\&bytes=\3\&rssi=\4/;s/\(.*\) \(.*\) \(.*\)/mac=\1\&ip=\2\&bytes=\3\&total=0\&rssi=/' | while read i; do wget -T10 -t2 --connect-timeout=10 --read-timeout=10 "https://red.personaltelco.net/nodedb/submit.php?host=`cat /proc/sys/kernel/hostname`$i" --no-check-certificate -q -O /dev/null 2>/dev/null; done 
}

tot()
{
#cmb | sort -r | uniq -w17 | awk '{print $3,$1,$2,$4}' | sort -nr | awk '{print $2,$3,$1,$4}'| grep -i $mac | sed 's/\(.*\) \(.*\) \(.*\) \(.*\)/\&mac=\1\&ip=\2\&bytes=\3\&total=\3\&rssi=\4/;s/\(.*\) \(.*\) \(.*\)/mac=\1\&ip=\2\&bytes=\3\&total=\3\&rssi=/' | while read i; do wget -T10 -t2 --connect-timeout=10 --read-timeout=10 "https://red.personaltelco.net/nodedb/submit.php?host=`cat /proc/sys/kernel/hostname`$i" --no-check-certificate -q -O /dev/null 2>/dev/null; done 
}

sta()
{
cmb | sort -r | uniq -w17 | awk '{print $3,$1,$2,$4}' | sort -nr | awk '{print $2,$3,$1,$4}' | while read i; do 
  D=`echo $i | awk '{print $3}'`
  if [ $D -ge 1048576 ]; then 
      echo $D | awk '{ sum+=$1/1024^2 }; END { printf ("%dM", sum )}'
    elif [ $D -le 1048575 -a $D -ge 1024 ]; then
      echo $D | awk '{ sum+=$1/1024 }; END { printf ("%dK", sum )}'
    else echo $D
  fi | xargs echo `echo $i | awk '{print $1,$2,$4}'`; done 2>/dev/null | awk '{print $1,$2,$4,$3}'
}

sig()
{
#s=`sta | sed '/^$/d' | grep -i "$1" | awk '{print $4}'`
s=$1
if [ $s ]; then
  if [ $s -ge 30 ]; then
      echo sig-100.gif
    elif [ $s -le 29 -a $s -ge 25 ]; then
      echo sig-75.gif
    elif [ $s -le 24 -a $s -ge 20 ]; then
      echo sig-50.gif
    elif [ $s -le 19 ]; then
      echo sig-25.gif
  fi
else
  echo sig-0.gif
fi
}

html()
{
T=$(grep -o "<title.*title>" /www/splash.html)
T1=$(echo "$T" | sed 's:<title>Personal Telco Project - \(.*\)</title>:\1:')
echo -e "<html>\n<head>\n$T"
echo -e "  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>"
echo -e "  <link rel=\"stylesheet\" type=\"text/css\" href=\"main.css\"/>"
echo -e "  <link rel=\"shortcut icon\" href=\"favicon.ico\"/>"
echo -e "</head>\n<body>"
echo -e "<div class=\"header\"><div class=\"headcontent\"><div class=\"tower\"><img src=\"images/ptp-logo.png\" width=\"41\" height=\"80\" alt=\"tower logo\"/></div><div class=\"toptext\"><img src=\"images/ptp-masthead.gif\" width=\"240\" height=\"27\" alt=\"personal telco project\"/></div><div class=\"topnav\">$T1</div></div></div><div class=\"body\"><div class=\"content\" style=\"margin-left:auto;margin-right:auto\">"
echo -e "<p><b>Uptime</b>:$(uptime)</p>"
echo -e "<p><b>Status</b>: $(usercount) users active at $(date)</p>"
echo -e "<table border="1" cellpadding="5">\n<tr><th>Client</th><th>MAC Address</th><th>Usage</th><th>Signal</th></tr>"
sta | sed '/^$/d' | while read i; do sig `echo $i|awk '{print $4}'`| xargs echo `echo $i | awk '{print $1,$2,$3}'` | sed 's^\(..\):\(..\):\(..\):\(..\):..:\(..\) \(.*\) \(.*\) \(.*\)^<tr><td align="center">\6</td><td align="center"><a href="http://standards.ieee.org/cgi-bin/ouisearch?\1\2\3">\1:\2:\3:\4:xx:\5</a></td><td align="right">\7</td><td align="center"><img src="images/\8"/></td></td>^'; done
echo -e "</table></div>\n</div>\n</body>\n</html>"
}

update()
{
sta | sed '/^$/d' | while read i; do sig `echo $i|awk '{print $4}'`| xargs echo `echo $i | awk '{print $1,$2,$3}'`; done 
}

hlp()
{
echo -e "<nocatstatus.sh> - usage: nocatstatus.sh -(option)"
echo -e "       client-status.sh is a script to parse client information"
echo -e "       "
echo -e "       Options"
echo -e "-c     - count total users"
echo -e "-t     - output current user table (for status page integration)"
echo -e "-o     - last connection date string (not yet)"
echo -e "-f     - nodedb update"
echo -e "-e	- send client expire total usage to nodedb"
echo -e "-h     - this"
}


case $1 in
"" ) hlp ;;
"-c" ) usercount ;;
"-m" ) cmb ;;
"-t" ) html ;;
"-o" ) sta ;;
"-e" ) tot ;;
"-f" ) sta2 ;;
"-h" ) hlp ;;
"-help" ) hlp ;;
esac
