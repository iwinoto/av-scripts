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
        echo "-o [100,200]     Frame offset from top left (Left,Top)"
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

#audio
# to get list of audio sources run:
# $ pactl list sources
# audio from built-in analogue stereo
# in Pulse Audio Volume Control GUI, make sure the desired monitor is not muted. Go to 
# "Input Devices", at the bottom make sure to show: "All Input Devices", make sure the
# desired input device is not muted.
#-f pulse -ac 2 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
# microphone: alsa_input.pci-0000_00_1b.0.analog-stereo
# where -ac is the number of input channels. 2 for streo, 1 for mono, etc.
# to mix more than one audio input use below, replacing '2' with number of audio inputs
#-filter_complex amix=inputs=2

#    -f pulse -ac 2 -ar 44100 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
#    -f alsa -i pulse \
#    -f pulse -i default

audio_source_monitor_analog=alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
audio_source_mic_analog=alsa_input.pci-0000_00_1b.0.analog-stereo

cmd="ffmpeg \
    -f pulse -ac 2 -ar 128000 -i $audio_source_monitor_analog \
    -framerate $framerate -video_size $size \
    -f x11grab -show_region 1 -i :0.0+$offset -c:v libx264 -preset veryfast -crf 18 \
    -c:a libfdk_aac -ar 44100 -q:a 1 \
    $output"
echo $cmd
$cmd


