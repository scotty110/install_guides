#!/bin/bash

set -eu
# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
	CHILD_DIR=$PWD
else
	CHILD_DIR=$PARENT_DIR/DIR
fi

# Install Things

exit
