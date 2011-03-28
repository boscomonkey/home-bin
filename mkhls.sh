#!/bin/sh

### constants
TRANSCODE_HLS="transcode_hls.sh"

### parameters
SOURCENAME="$1"

# default to 10 seconds segment duration
DURA=10
test -n "$2" && DURA="$2"

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
for BITRATE in 110k 200k 400k 600k 800k
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