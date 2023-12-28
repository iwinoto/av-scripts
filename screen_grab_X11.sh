#!/bin/bash

print_help()
{
        echo 
        echo "Screen grab to x264 video using ffmpeg"
	echo "Use xwininfo to get dimension and offset of a window to capture."
        echo
        echo "Usage:"
        echo "$0 -s <string> -o <string> -f <integer> <filename>"
        echo
        echo "filename must be libx264 compatible (flv and mp4 both work)"
        echo
        echo "Options are:"
        echo "-s [1024x768]    Frame size (WxH)"
        echo "-o [100,200]     Frame offset from top left (Top,Left)"
        echo "-r [15]          Framerate (fps)"
        echo "-h               Help message"
        echo
}

size=1024x768
offset=100,200
framerate=15
output=output.mpg

while getopts "s:o:r:h" optname
do
    case "$optname" in
      "s")
        size=$OPTARG
        ;;
      "o")
        offset=$OPTARG
        ;;
      "r")
        framerate=$OPTARG
        ;;
      "h")
        print_help
        exit $?
        ;;
      "?")
        echo "Unknown option $OPTARG"
        print_help
        exit $?
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        print_help
        exit $?
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        print_help
        exit $?
        ;;
    esac
done

shift $(($OPTIND -1))
if [ -n $1 ]; then
   output=$1
fi

cmd="ffmpeg -framerate $framerate -video_size $size -f x11grab -show_region 1 -i :0.0+$offset -vcodec libx264 -crf 0 -preset ultrafast $output"
echo $cmd

$cmd


