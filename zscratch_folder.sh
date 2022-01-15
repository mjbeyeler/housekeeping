#!/bin/bash

# WHAT IT DOES
# copies gziped folder content, to corresponding location in scratch

# HOW-TO
# ~/zscratch_folder.sh $(pwd -P) archived_folder

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config.sh

INPUT_PARENT_DIR=$1
INPUT_ZDIR=$2

OUTPUT_PARENT_DIR=$(sed "s/.*sbergman\///g" <<<"$INPUT_PARENT_DIR")
#PARENT_DIR=$(echo $OUT_DIR | sed 's|\(.*\)/.*|\1|')

echo $SCRATCH_DIR$OUTPUT_PARENT_DIR
echo $INPUT_ZDIR

# making sure parent folders exist, else create them
mkdir -p $SCRATCH_DIR$OUTPUT_PARENT_DIR

tar xzf $INPUT_ZDIR -C $SCRATCH_DIR$OUTPUT_PARENT_DIR/
