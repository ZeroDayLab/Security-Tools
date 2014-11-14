!/usr/bin/env bash
##################
# A simple ssh scanner for displaying accepted ciphers
# Written by Stefan Michielse
#
ip=$1

if [ $# = 0 ]; then
echo Usage: ssh-scan.sh IP / DNS
echo Example: ssh-scan.sh 127.0.0.1 / localhost
exit
fi

TMP=$(mktemp -d)
#Debugging echo "Directory made :"$TMP
#Debugging echo "Nohup.out is located :"$TMP"/nohup.out"
cd $TMP
# timeout is set to 10 seconds then it will send a SIGKILL signal to this script
timeout -s 9 5 nohup ssh -vv $ip

a=$(awk 'BEGIN {FS=",";} NR==35 { for (i=3; i<=NF;i++) print $i}' $TMP/nohup.out|awk '!/ecdh/')
b=$(awk 'BEGIN {FS=",";} NR==36 { for (j=2; j<=NF;j++) print $j}' $TMP/nohup.out|awk '!/ecdsa/')
c=$(awk 'BEGIN {FS=",";} NR==37 { for (k=3; k<=NF;k++) print $j}' $TMP/nohup.out|sort|awk '!/ecdh/')
d=$(awk 'BEGIN {FS=",";} NR==39 { for (l=3; l<=NF;l++) print $k}' $TMP/nohup.out|sort)
echo "=============================="
echo "Kex Algorithms" $(awk 'END{print FNR}' $l)
echo "=============================="
for m in $a;do echo $m;done
echo "=============================="
echo "Server Host Key Algorithms"
echo "=============================="
for n in $b;do echo $n;done
echo "=============================="
echo "Encryption Algorithms"
echo "=============================="
for o in $c;do echo $o;done
echo "=============================="
echo "MAC Algorithms"
echo "=============================="
for p in $d;do echo $p;done
#remove the temp directory
echo "Removing directory :" $TMP
rm $TMP
