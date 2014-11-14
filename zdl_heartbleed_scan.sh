#!/usr/bin/env bash
#######################
#
# a simple SSL parser for nmap, written by Stefan Michielse
#
# The script will check all the ssl/http ports found in the nmap file it
# will check if this is vulnerable to Heartbleed CVE-2014-0160
######################

filename=$(basename "$1")

if [ $# = 0 ]; then
   echo Usage:zdl_heartbleed_scan.sh filename
   echo Example: zdl_heartbleed_scan.sh nmap.R2222-A01.discovery.nmap
   exit
fi

for ip in $(awk '/Nmap scan report for/ {print $5}' $1); do
for port in $(awk 'BEGIN { FS="/"} /ssl\/http/ {print $1}' $1);do
heartbleeder $ip:$port >> heartbleed.$ip.$port
 done
done
