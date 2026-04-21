#!/bin/bash

# Print "<dir>\t<count>" where <count> is the number of .rb files under
# the given directory. Delegates the listing to find-rb-files.sh.
#
# Usage: count-rb-files.sh [DIR=.]

TOPDIR="${1:-.}"
echo -ne "${TOPDIR}\t"
find-rb-files.sh "$TOPDIR" | wc -l | sed -E 's/[ \s\t]+//g'
