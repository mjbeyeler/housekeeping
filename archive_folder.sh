#!/bin/bash

# Summary
# This scipt copies/moves a folder and all its content to the backed-up archive.

# How-to
# 1) Navigate to parent of folder of interest
# 2) ~/housekeeping/archive_folder.sh folder_of_interest keep/delete

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$(pwd -P)
TARGET_DIR=$1
DELETE=$2

OUTPUT_PARENT_DIR=$ARCHIVE_DIR/$(sed "s|$SCRATCH_DIR||g"<<<"$INPUT_PARENT_DIR")

INPUT_DIR=$INPUT_PARENT_DIR/$TARGET_DIR
OUTPUT_DIR=$OUTPUT_PARENT_DIR/$TARGET_DIR
#echo $INPUT_DIR $OUTPUT_DIR

# making sure parent folders exist, else creates them
mkdir -p $OUTPUT_PARENT_DIR

# creating archive
if [[ "$DELETE" = delete ]]; then
	echo rsync and deleting source
	rsync --remove-source-files -ah --info=progress2 $INPUT_DIR $OUTPUT_DIR && rm -rf $INPUT_DIR
elif [[ "$DELETE" = keep ]]; then
	echo rsync and keeping source
	rsync -ah --info=progress2 $INPUT_DIR $OUTPUT_DIR
else
	echo Please specify whether to \"keep\" or \"delete\" source.
fi
