#!/bin/bash -e

# Install Atom on Ubuntu/Debian

cd $HOME/Downloads

PKG_NAME=atom-installer.github.com.deb
FILE=/srv/pkg/$PKG_NAME
sudo dpkg -i $FILE
