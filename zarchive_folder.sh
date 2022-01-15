#!/bin/bash

# WHAT IT DOES
# gzips any folder of choice, moves it to the Jura archive, and then deletes the source folder

# HOW-TO
# cd to parent of folder to archive, then type following command:
# (copy script to home directory for easy use)
# $HOME/archive_folder.sh $(pwd -P) *experiment_id*

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$1
INPUT_DIR=$2
KEEP_SRC=$3

OUTPUT_PARENT_DIR=$(sed "s/.*sbergman\///g" <<<"$INPUT_PARENT_DIR")
#PARENT_DIR=$(echo $OUT_DIR | sed 's|\(.*\)/.*|\1|')


# making sure parent folders exist, else create them
mkdir -p $ARCHIVE_DIR$OUTPUT_PARENT_DIR
# creating archive

cd $INPUT_PARENT_DIR
if [[ "$KEEP_SRC" = "TRUE" ]]
then
	echo keeping source: TRUE
	tar czf $ARCHIVE_DIR$OUTPUT_PARENT_DIR/$INPUT_DIR.tgz $INPUT_DIR
else
	echo keeping source: FALSE
	tar czf $ARCHIVE_DIR$OUTPUT_PARENT_DIR/$INPUT_DIR.tgz $INPUT_DIR && rm -rf $INPUT_DIR
fi
