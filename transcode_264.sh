#!/bin/sh
#
# http://rob.opendot.cl/index.php/useful-stuff/ffmpeg-x264-encoding-guide/

INPUT="$1"
OUTPUT="$2"

# default to 800k bit rate
BIT_RATE=800k
test -n "$3" && BIT_RATE="$3"

ffmpeg -i "${INPUT}" -vcodec libx264 -vpre slow -b ${BIT_RATE} -threads 0 "${OUTPUT}"
