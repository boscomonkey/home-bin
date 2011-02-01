#/bin/sh

# git-zip.sh
#
# Creates a zip file of the HEAD of the current git repository

CWD=`basename $PWD`
git archive --format=zip --prefix=${CWD}/ -9 HEAD > ../${CWD}.zip
