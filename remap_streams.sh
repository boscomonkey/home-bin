#!/bin/sh
#
# Remaps the order of the audio and video streams in a 24/24 Actu video.
#
ffmpeg -i "$1" -acodec copy -vcodec copy -map 0:1 -map 0:0 "$2"
