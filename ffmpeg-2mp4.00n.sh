#!/bin/sh

# example:
# /pub/ffmpeg-scripts/processDir.sh "./20100913/20100913/*.mts" /pub/ffmpeg-scripts/ffmpeg-mts2avi.sh
#

print_help()
{
        echo
        echo "Transcode a video file to mp4 track to a file using ffmpeg"
        echo
        echo "Usage:"
        echo "$0 -r <integer 0-60 [23]> <file name>"
        echo
        echo "<file name> is the video file to convert."
        echo "output is <file name>.mp4. Where there is a name conflict, the"
        echo "file will be appended with timestamp."
        echo
        echo "Options are:"
        echo "-r [23]  Constant Rate Factor (CRF). 0-51"
        echo "          Where 0 is lossless, 23 is default, and 51 is worst possible."
        echo "          A lower value is a higher quality and a subjectively sane range"
        echo "          is 18-28. Consider 18 to be visually lossless or nearly so it"
        echo "          should look the same or nearly the same as the input but it"
        echo "          isn't technically lossless."
        echo "-h        This help message"
        echo
}

crf=20

while getopts "r:h" optname
do
    case "$optname" in
      "r")
        crf=$OPTARG
        ;;
      "h")
        print_help
        #exit $?
        ;;
      "?")
        echo "Unknown option $OPTARG"
        print_help
        #exit $?
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        print_help
        #exit $?
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        print_help
        #exit $?
        ;;
    esac
done

shift $(($OPTIND -1))
if [ $1 ]; then
    input="$1"

    output="${input%\.*}.mp4"
    if [ -f $output ];
    then
        output="${input%\.*}.`date +%H%M%S`.mp4"
    fi
    echo -n "title Converting $input to mp4 as $output"

    ffmpeg -i "$input" -filter:v yadif -c:v libx264 -crf $crf -c:a libfdk_aac -b:a 256k "$output"

    touch -r "$input" "$output"
fi
