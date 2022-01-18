#!/bin/bash

# Summary
# This scipt copies a folder and all its content to scratch space.

# How-to
# 1) Navigate to parent of folder of interest
# 2) ~/housekeeping/scratch_folder.sh folder_of_interest

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$(pwd -P)
TARGET_ZDIR=$1

OUTPUT_PARENT_DIR=$SCRATCH_DIR/$(sed "s|$ARCHIVE_DIR||g"<<<"$INPUT_PARENT_DIR")

mkdir -p $OUTPUT_PARENT_DIR

tar xzf $INPUT_PARENT_DIR/$TARGET_ZDIR -C $OUTPUT_PARENT_DIR
