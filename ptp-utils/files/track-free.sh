#!/bin/sh

while true ; do echo $(date) $(cat /proc/uptime) $(free) ; sleep 60 ; done
