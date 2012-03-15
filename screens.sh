#!/bin/sh

screen -ls | ruby -ne 'puts $1 if %r(^\s+(\d+\.\w+)\s+\(\d\d/\d\d/\d\d)'
