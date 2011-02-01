#!/bin/bash
#
# forward my local port (e.g., 3000) to REMOTE_HOST's port
# and run top to keep tunnel from closing

REMOTE_PORT=$1
LOCAL_PORT=$2
REMOTE_HOST=$3

ssh -t -g -R :$REMOTE_PORT:0.0.0.0:$LOCAL_PORT $REMOTE_HOST "top d 15"
