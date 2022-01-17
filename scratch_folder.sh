#!/bin/bash

# Usage tip:
# copy the script in your home directory. It will be more easy to use.

# How-to
# ~/scratch_folder.sh $(pwd -P) folder

# Explanation
# This will copy any folder and all its content to scratch space.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$1/
TARGET_DIR=$2

OUTPUT_PARENT_DIR=$(sed "s/.*sbergman\///g" <<<"$INPUT_PARENT_DIR")
#PARENT_DIR=$(echo $OUT_DIR | sed 's|\(.*\)/.*|\1|')

INPUT_DIR=$INPUT_PARENT_DIR$TARGET_DIR/ # slash needed
OUTPUT_DIR=$SCRATCH_DIR$OUTPUT_PARENT_DIR$TARGET_DIR

#echo OUTPUT_PARENT_DIR $OUTPUT_PARENT_DIR
#echo INPUT_DIR $INPUT_DIR
#echo OUTPUT_DIR $OUTPUT_DIR

# making sure parent folders exist, else create them
mkdir -p $SCRATCH_DIR$OUTPUT_PARENT_DIR
# creating scratch copy

rsync -ah --info=progress2 $INPUT_DIR $OUTPUT_DIR
