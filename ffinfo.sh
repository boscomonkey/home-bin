#!/bin/sh

for i in $*; do
    ffmpeg -i "$i" 2>&1 | ruby -ne 'n ||= 0; n += 1; print unless n <= 10'
done
