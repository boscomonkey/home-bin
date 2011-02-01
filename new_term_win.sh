#!/bin/sh 
osascript <<END 
tell app "Terminal" to do script "cd \"`pwd`\"" 
END
