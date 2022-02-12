#!/bin/bash

# Summary
# This scipt moves selected scratch files to the corresponding folder in the archive.

# How-to
# 1) Navigate to parent of folder of interest
# 2) ~/housekeeping/scratch_files.sh $(ls *filesOfInterest*) *more* *files*


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh
INPUT_PARENT_DIR=$(pwd -P)

KEEP_OR_DELETE=$1

echo "$SCRATCH_DIR/*" "$INPUT_PARENT_DIR"
echo $SCRATCH_DIR $INPUT_PARENT_DIR
if [[ $INPUT_PARENT_DIR != *"$SCRATCH_DIR"* ]]; then
        echo Abort: You are not in scratch
        exit 1
fi

if [[ "$KEEP_OR_DELETE" = delete ]]; then
	echo Moving files to archive, deleting original
elif [[ "$KEEP_OR_DELETE" = keep ]]; then
	echo Copying files to archive, keeping original
else
	echo Abort: Missing keep/delete argument
	exit 1
fi

OUTPUT_PARENT_DIR=$SCRATCH_DIR/$(sed "s|$ARCHIVE_DIR||g"<<<"$INPUT_PARENT_DIR")

# making sure parent folders exist, else creates them
mkdir -p $OUTPUT_PARENT_DIR

for i in "${@:2}"; do
	echo $i
	if [[ "$KEEP_OR_DELETE" = delete ]]; then
		rsync  --remove-source-files -ah --info=progress2 $INPUT_PARENT_DIR/$i $OUTPUT_PARENT_DIR
	else
		rsync  -ah --info=progress2 $INPUT_PARENT_DIR/$i $OUTPUT_PARENT_DIR
	fi
done
