#!/bin/sh

# example:
# /pub/ffmpeg-scripts/processDir.sh "./20100913/20100913/*.mts" /pub/ffmpeg-scripts/ffmpeg-mts2avi.sh
#

echo -n "title Converting $1 to avi"

ffmpeg -i "$1" -filter:v yadif -f avi -c:v mpeg4 -vtag XVID -aspect 16:9 -qmin 3 -qmax 5 -mbd 2 -bf 2 -flags +mv4+aic -trellis 2 -cmp 2 -subcmp 2 -g 300 -c:a libmp3lame -r:a 48000 -b:a 128k "${1%\.*}.avi"
