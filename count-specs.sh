#!/bin/bash

# Count *_spec.rb files under a directory and print "<dir><count>".
#
# Usage: count-specs.sh [DIR=.]

DIR=$1
test -n "$DIR" || DIR=.

echo -e "${DIR}$(find "$DIR" -type f -name '*_spec.rb' | wc -l)"
