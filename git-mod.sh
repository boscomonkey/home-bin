#!/bin/sh

git st | ruby -ne 'puts "#{$1}" if /^\#\s+modified:\s+(\S+)$/'
