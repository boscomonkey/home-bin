#!/bin/sh

# Transcodes a video into HLS with variant bitrates of 800k, 600k, and
# 400k. Places all variant slices into their own bitrate directory
# under a distributable directory whose name is the basename of the
# source video.
#
# USAGE:	mkhls.sh SOURCE_VIDEO OPTIONAL_BITRATES
#
#		OPTIONAL_BITRATES can be omitted, but can be specified
#		via a quoted list of bitrates with each rate on a
#		different line. For example.
#
#		$ mkhls casino-royale.mp4 "1200k
#		> 900k
#		> 600k"

### constants
TRANSCODE_HLS="transcode_264.sh"

### parameters
SOURCENAME="$1"

# default to 10 seconds segment duration
DURA=10

# default bitrates to 800k 600k 400k
RATES="800k
600k
400k"
test -n "$2" && RATES="$2"

### sanity check
test -n "${SOURCENAME}" || exit -1
FNAME=`basename "${SOURCENAME}"`
BASENAME="${FNAME%.*}"

### output & work directories
OUTDIR="${BASENAME}"
WORKDIR="${BASENAME}.work"
mkdir "${OUTDIR}"
mkdir "${WORKDIR}"

### cycle through bit rates
VARIANTS=""
for BITRATE in ${RATES}
do
    TSNAME="${WORKDIR}/${BASENAME}-${BITRATE}.ts"
    ${TRANSCODE_HLS} ${SOURCENAME} ${TSNAME} ${BITRATE}

    BITDIR="${OUTDIR}/${BITRATE}"
    mkdir "${BITDIR}"
    pushd "${BITDIR}"
    mediafilesegmenter -i index.m3u8 -t "${DURA}" -generate-variant-plist "../../${TSNAME}"
    popd

    PLIST="${WORKDIR}/${BASENAME}-${BITRATE}.plist"
    VARIANTS="${VARIANTS} ${BITRATE}/index.m3u8 ${PLIST} "
done

### create variant play list
echo ${VARIANTS} | xargs variantplaylistcreator -o "${OUTDIR}/${BASENAME}.m3u8"