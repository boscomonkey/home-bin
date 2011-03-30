#!/bin/sh

ffmpeg -i "$1" 2>&1 | ruby -ne 'if /Video:.+?(\d+)x(\d+)/; puts "#{$1}\t#{$2}"; exit; end'
