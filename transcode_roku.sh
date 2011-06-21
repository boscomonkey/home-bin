#!/bin/sh
#
# http://rob.opendot.cl/index.php/useful-stuff/ffmpeg-x264-encoding-guide/

INPUT="$1"
OUTPUT="$2"

# default to 800k bit rate
BIT_RATE=800k
test -n "$3" && BIT_RATE="$3"

ffmpeg -i "${INPUT}" -acodec libfaac -ab 128 -vcodec libx264 -vpre roku -vpre main -b ${BIT_RATE} -threads 0 "${OUTPUT}"
