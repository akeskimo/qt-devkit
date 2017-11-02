#!/bin/bash -e

# This script adds directory to .bashrc


# Args:
# $1 ~ Absolute path of directory to add to PATH variable in .bashrc

CMD=$1
if ! grep -Fxq "$CMD" $HOME/.bashrc; then
    echo $CMD >> $HOME/.bashrc
    echo Line \"$CMD\" added to .bashrc
fi
