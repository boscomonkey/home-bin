#!/bin/bash

# List every .rb file under a directory.
#
# Usage: find-rb-files.sh [DIR=.]

TOPDIR="${1:-.}"
find "$TOPDIR" -type f -name '*.rb'
