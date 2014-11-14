#!/usr/bin/env bash
##################
# A simple pdf parser for SoW. The output can be redirected to a file
# 
# Written by Stefan Michielse
#
# Dependencies pdfinfo and pdftotext
filename=$(basename "$1")

if [ $# = 0 ]; then
   echo "Usage : pdf-parser.sh filename"
   echo "Example: pdf-parser.sh VzB_R2073.A03_21May2014_SoW_v1.0.pdf"
   exit
fi
#echo $filename

lastpage=$(pdfinfo $filename|awk '/Pages/ { print $2 }')
pdftotext -f 1 -l $lastpage -layout -nopgbrk $filename
filetxt=$(echo $filename|sed 's/...$/txt/')
grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' $filetxt|awk '!/213.53.134.0|62.190.106.0|62.189.190.137|194.7.150.240/'


# The ip address which are deleted by the awk command are Verizon Business IP's
# Note unfortunately sometimes it will list paragraph numbers which could be IP's for instance
# 3.2.3.1 or 3.2.3.2 by simply adding awk '!/3.2.3.1|3.2.3.2/' or sed add the end of the command. This can be used to remove these 'unwanted' values
# For example pdf-parser.sh VzB_R2073.A03_21May2014_SoW_v1.0.pdf|awk '!/3.2.3.1|3.2.3.2/'
