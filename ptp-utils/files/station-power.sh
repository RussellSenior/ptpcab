#!/bin/sh

for i in $(iwinfo | awk '$0 ~ /^wlan/ { print $1 }') ; do echo $i ; iwinfo $i assoclist ; done
