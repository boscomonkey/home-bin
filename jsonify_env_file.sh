#!/bin/bash

# Converts a dotenv file to JSON. This script is capable of parsing
# multiline values, as well as ignoring comments. The dotenv file must
# be specified as the 1st argument - STDIN input is not supported.
#
# Useful for parsing output of `aptible config`.

# converts env vars to JSON
CMD="ruby -r json -e 'puts JSON.pretty_generate(ENV.keys.sort.map { |key| [key, ENV[key]] }.to_h)'"

# first arg names envfile
ENVFILE="$1"
if [ -z "$ENVFILE" ]; then
    echo "USAGE: $0 DOTENV_FILE" > /dev/stderr
    exit 1
fi

# jsonify barebones env vars
barebones_str=$(env -i bash -c "$CMD")

# jsonify envfile env vars
envfile_str=$(env -i bash -c "set -a; . ${ENVFILE}; set +a; ${CMD}")

# subtract first json from second
ruby -r json -e "
     barebones = JSON.parse(ARGV[0])
     envfile = JSON.parse(ARGV[1])
     diff_keys = envfile.keys - barebones.keys
     puts JSON.pretty_generate(diff_keys.sort.map { |key| [key, envfile[key]] }.to_h)
" \
     "$barebones_str" \
     "$envfile_str"
