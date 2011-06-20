#!/bin/sh

# From Ion Cannon's "iPhone HTTP Streaming with FFMpeg and an Open
# Source Segmenter" article at http://bit.ly/asid6D

BITRATE=800k
test -n "$3" && BITRATE="$3"

ffmpeg -i "$1" -f mpegts -acodec libfaac -ar 22050 -ab 40k -vcodec libx264 -b "${BITRATE}" -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -subq 5 -trellis 1 -refs 1 -coder 0 -me_range 16 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 200k -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -level 30 -g 30 -async 2 -r 24 -threads 0 "$2"
