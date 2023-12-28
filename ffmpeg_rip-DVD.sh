#!/bin/bash

DVD_PATH=$1
TRACK=$2
OUTPUT_PATH=$3
OUTPUT_NAME=$4

echo "DVD_PATH = ${DVD_PATH}"
echo "TRACK = ${TRACK}"
echo "OUTPUT_PATH = ${OUTPUT_PATH}"
echo "OUTPUT_NAME = ${OUTPUT_NAME}"


cat ${DVD_PATH}/VIDEO_TS/VTS_${TRACK}_*.VOB | ffmpeg -i - -c:v libx264 -crf 12 -c:a aac -movflags +faststart ${OUTPUT_PATH}/${OUTPUT_NAME}-${TRACK}.mp4


