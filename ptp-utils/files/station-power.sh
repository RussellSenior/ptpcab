#!/bin/sh

for i in $(iwinfo | awk '$0 ~ /^[a-z]/ { print $1 }') ; do echo $i ; iwinfo $i assoclist ; done
