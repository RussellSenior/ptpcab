#!/bin/sh

awk '{ split($3,a,".") ; print sprintf("%03d.%03d.%03d.%03d",a[1],a[2],a[3],a[4]),$2,$4 }' /tmp/dhcp.leases | sort | sed 's/^010.011./10.11./g' | sed 's|\.0|.|g' | sed 's|\.0|.|g'
