#!/bin/sh

ffmpeg -i "$1" -acodec copy -vcodec copy -threads 0 "$2"
