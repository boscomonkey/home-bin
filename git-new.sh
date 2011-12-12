#!/bin/sh

git status | ruby -ne 'puts("\"#{$1}\"") if /^#\t([^:]+)?\s+$/'
