#!/bin/bash

# Fetch FedEx tracking data for TRACKING_NUMBER from the Shippo API and
# cache the JSON response to $OUT_DIR/$TRACKING_NUMBER.json (default
# OUT_DIR=shippo). Subsequent calls print the cached copy.
#
# Requires SHIPPO_API_TOKEN in the environment.
#
# Usage: shippo_track.sh TRACKING_NUMBER

test -n "$OUT_DIR" || OUT_DIR=shippo

TRACKING_NUMBER=$1
test -n "$TRACKING_NUMBER" || exit 1

OUT_FILE="$OUT_DIR/$TRACKING_NUMBER.json"
if [ -e "$OUT_FILE" ]; then
    cat "$OUT_FILE"
else
    test -n "$SHIPPO_API_TOKEN" || exit 1

    curl https://api.goshippo.com/tracks/ \
         -H "Authorization: ShippoToken $SHIPPO_API_TOKEN" \
         -H "Content-Type: application/json" \
         -d "{\"carrier\": \"fedex\", \"tracking_number\": \"$TRACKING_NUMBER\"}" \
        | ruby -r json -e 'puts JSON.pretty_generate(JSON.parse(ARGF.read))' \
        | tee "$OUT_FILE"
fi
