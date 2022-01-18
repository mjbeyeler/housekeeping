#!/bin/bash

# Summary
# This scipt copies/moves a folder and all its content to the backed-up archive as a gzip archive.

# How-to
# 1) Navigate to parent of folder of interest
# 2) ~/housekeeping/zarchive_folder.sh folder_of_interest keep/delete

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$(pwd -P)
TARGET_DIR=$(sed "s|\/||g"<<<"$1")
DELETE=$2

OUTPUT_PARENT_DIR=$ARCHIVE_DIR/$(sed "s|$SCRATCH_DIR||g"<<<"$INPUT_PARENT_DIR")

INPUT_DIR=$INPUT_PARENT_DIR/$TARGET_DIR
OUTPUT_DIR=$OUTPUT_PARENT_DIR/$TARGET_DIR

mkdir -p $OUTPUT_PARENT_DIR

if [[ "$DELETE" = delete ]]; then
	echo gzipping, archiving, and deleting source
        tar czf $OUTPUT_DIR.tgz $TARGET_DIR && rm -rf $TARGET_DIR
elif [[ "$DELETE" = keep ]]; then
        echo gzipping and archiving, keeping source
	tar czf $OUTPUT_DIR.tgz $TARGET_DIR
else
	echo Please specify whether to \"keep\" or \"delete\" source.
fi
