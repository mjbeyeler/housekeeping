#!/bin/bash

# Summary
# This scipt copies selected files to the corresponding folder in scratch.

# How-to
# 1) Navigate to parent of folder of interest
# 2) ~/housekeeping/scratch_files.sh $(ls *filesOfInterest*) *more* *files*

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$(pwd -P)

OUTPUT_PARENT_DIR=$SCRATCH_DIR/$(sed "s|$ARCHIVE_DIR||g"<<<"$INPUT_PARENT_DIR")

# making sure parent folders exist, else creates them
mkdir -p $OUTPUT_PARENT_DIR

for i in $@; do
	echo $i
	rsync -ah --info=progress2 $INPUT_PARENT_DIR/$i $OUTPUT_PARENT_DIR
done
