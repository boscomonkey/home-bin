#!/bin/sh
#
# http://rob.opendot.cl/index.php/useful-stuff/ffmpeg-x264-encoding-guide/

INPUT="$1"
OUTPUT="$2"

ffmpeg -i "${INPUT}" -vcodec libx264 -vpre slow -threads 0 "${OUTPUT}"
