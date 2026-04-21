#!/bin/bash

# For every ordered pair of *.txt files in the current directory,
# print the case-insensitive line intersection (comm -12i). Useful for
# spotting shared entries across a set of word lists.

for left in *.txt; do
    for right in *.txt; do
        if [ "$left" != "$right" ]; then
            comm -12i <(sort "$left") <(sort "$right")
        fi
    done
done
