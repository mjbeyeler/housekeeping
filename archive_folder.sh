#!/bin/bash

# Usage tip:
# copy the script in your home directory. It will be more easy to use.

# How-to
# ~/archive_folder.sh $(pwd -P) folder keep/delete

# Explanation
# This will move any folder and all its content over to the archive
# You can choose whether to delete or keep the source.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$1/
TARGET_DIR=$2
DELETE=$3


OUTPUT_PARENT_DIR=$(sed "s/.*sbergman\///g" <<<"$INPUT_PARENT_DIR")
#PARENT_DIR=$(echo $OUT_DIR | sed 's|\(.*\)/.*|\1|')

INPUT_DIR=$INPUT_PARENT_DIR$TARGET_DIR/ # slash needed
OUTPUT_DIR=$ARCHIVE_DIR$OUTPUT_PARENT_DIR$TARGET_DIR


#echo OUTPUT_PARENT_DIR $OUTPUT_PARENT_DIR
#echo INPUT_DIR $INPUT_DIR
#echo OUTPUT_DIR $OUTPUT_DIR

# making sure parent folders exist, else create them
mkdir -p $ARCHIVE_DIR$OUTPUT_PARENT_DIR
# creating archive

if [[ "$DELETE" = delete ]]; then
	echo rsync and deleting source
	rsync --remove-source-files -a $INPUT_DIR $OUTPUT_DIR && rm -rf $INPUT_DIR
elif [[ "$DELETE" = keep ]]; then
	echo rsync and keeping source
	rsync -a $INPUT_DIR $OUTPUT_DIR
else
	echo Please specify whether to \"keep\" or \"delete\" source.
fi
