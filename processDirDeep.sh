#!/bin/sh
#../ffmpeg-scripts/processDir.sh "./20110807/20110807/*.MTS" ../ffmpeg-scripts/ffmpeg-mts2avi.sh

#for f in `find "$1" -type f -name "$2" | sort`
find "$1" -type f -name "$2" -print0 | while IFS= read -r -d $'\0' f
do
	echo
	echo "processing file $f with $3"
	"$3" "$f"
done


