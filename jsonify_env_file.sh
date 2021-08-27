#!/bin/bash

ENVFILE="$1"
if [ -z "$ENVFILE" ]; then
    echo "USAGE: $0 DOTENV_FILE" > /dev/stderr
    exit 1
fi

BAREBONES_VARS_FNAME=barebones.json
ENV_JSON_CMD="ruby -r json -e 'puts JSON.pretty_generate(ENV.keys.sort.map { |key| [key, ENV[key]] }.to_h)'"
ENVFILE_VARS_FNAME=envfile.json

# jsonify Bash barebones env vars
env -i bash -c "$ENV_JSON_CMD" > $BAREBONES_VARS_FNAME

# jsonify Bash envfile env vars
env -i bash -c "set -a; . ${ENVFILE}; set +a; ${ENV_JSON_CMD}" > $ENVFILE_VARS_FNAME

# subtract first json from second
ruby -r json -e "
     barebones = JSON.parse(File.read('$BAREBONES_VARS_FNAME'))
     envfile = JSON.parse(File.read('$ENVFILE_VARS_FNAME'))
     diff_keys = envfile.keys - barebones.keys
     puts JSON.pretty_generate(diff_keys.sort.map { |key| [key, envfile[key]] }.to_h)
"
