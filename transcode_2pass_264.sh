#!/bin/sh
#
# http://rob.opendot.cl/index.php/useful-stuff/ffmpeg-x264-encoding-guide/

INPUT="$1"
OUTPUT="$2"

# default to 800k bit rate
BIT_RATE=800k
test -n "$3" && BIT_RATE="$3"

# two passes - first pass doesn't do audio
ffmpeg -i "${INPUT}" -an -pass 1 -vcodec libx264 -vpre slow_firstpass -b ${BIT_RATE} -threads 0 "${OUTPUT}"
ffmpeg -i "${INPUT}" -acodec libfaac -pass 2 -vcodec libx264 -vpre slow -b ${BIT_RATE} -threads 0 -y "${OUTPUT}"
