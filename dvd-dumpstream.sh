#mplayer -dumpstream dvd://1 -nocache -dvd-device /dev/sr0 -dumpfile "/home/iwinoto/Videos/movies/The Hobbit-The Battle of the Five Armies.mpg"

#!/bin/bash

print_help()
{
        echo 
        echo "Dump a DVD track to a file using mplayer -dumpstream"
        echo
        echo "Usage:"
        echo "$0 -t <integer> <file name>"
        echo
        echo "filename must have mpg extension."
        echo
        echo "Options are:"
        echo "-t [1]    Track in the DVD to dump"
        echo "-h        Help message"
        echo
}

track=1
output=dvdDump_track_$track.mpg

while getopts "t:h" optname
do
    case "$optname" in
      "t")
        track=$OPTARG
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

cmd="mplayer -dumpstream dvd://$track -nocache -dvd-device /dev/sr0 -dumpfile $output"

echo $cmd

$cmd


