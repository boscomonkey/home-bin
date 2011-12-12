#!/bin/sh

git status | ruby -ne 'puts("\"#{$1}\"") if /^\#\s+modified:\s+(.+)?\s+$/'
