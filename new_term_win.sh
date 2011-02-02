#!/bin/sh 
#
# http://superuser.com/questions/127117/spawn-a-new-terminal-window-mac-os-x
#
osascript <<END 
tell app "Terminal" to do script "cd \"`pwd`\"" 
END
