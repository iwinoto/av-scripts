#!/bin/sh
# Directory to be processed must be passed in quotes.
# Example:
# ./processDir.sh "../camera/20110218/*.MTS" ./avi-wide.sh
# 
for f in $1
do
	echo Processing file '"$f"' with command "$2"
	$2 "$f"
done
