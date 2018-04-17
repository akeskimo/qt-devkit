#!/bin/bash -e

PYCHARM_VERSION=pycharm-community-2018.1.1
DEST=$HOME/$PYCHARM_VERSION
FILE=$HOME/Downloads/$PYCHARM_VERSION
wget -o $FILE https://download.jetbrains.com/python/$PYCHARM_VERSION.tar.gz

DEST=$HOME/$PYCHARM_VERSION
mkdir $DEST
tar -xvf $FILE -C $DEST
