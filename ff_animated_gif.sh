#!/bin/bash

# Using ffmpeg, converts a movie into an animated gif as per
# https://gist.github.com/dergachev/4627207
#
# ~/bin/ff_animated_gif.sh MOVIE_FNAME GIF_FNAME

MOVIE_FNAME=$1
test -n "$MOVIE_FNAME" || exit 1

GIF_FNAME=$2
test -n "$GIF_FNAME" || exit 2

ffmpeg -i "$MOVIE_FNAME" -pix_fmt rgb24 -f gif - | gifsicle --optimize=3 --delay=3 > "$GIF_FNAME"
