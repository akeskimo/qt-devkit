#!/bin/bash -e

cd $HOME/Downloads

PKG_NAME=code_1.15.1-1502903936_amd64.deb
FILE=/srv/pkg/$PKG_NAME
sudo dpkg -i $FILE