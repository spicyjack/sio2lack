#!/bin/sh

# script for making an ISO filesystem, for CD burning

VERSION="2009.1"
OUTPUT_DIR=/opt/sourcecode/ISO_Projects/
INPUT_DIR=$OUTPUT_DIR/xlack
RELEASE_DATE=$(/bin/date "+%d%b%Y-%H.%M.%S")
BANNER="/tmp/xlack.banner.txt"

if [ ! -e $BANNER ]; then
    echo "ERROR: file ${BANNER} not found!"
    exit 1
fi
echo "sedifying $BANNER to $INPUT_DIR/isolinux/banner.txt"
cat $BANNER | sed "{ s!:RELEASE_DATE:!${VERSION} ${RELEASE_DATE}!g; }" \
    > $INPUT_DIR/isolinux/banner.txt

MKISOFS=$(which mkisofs)

# -f follow symlinks
$MKISOFS -f -r -J -v \
-A "LACK - XWindows Version - ${RELEASE_DATE}" \
-publisher "http://code.google.com/p/lack" \
-p "Brian Manning" \
-V "XLACK-$VERSION" \
-c isolinux/boot.cat \
-b isolinux/isolinux.bin \
-no-emul-boot -boot-load-size 4 -boot-info-table \
-o xlack.$VERSION.x86.iso \
$INPUT_DIR
