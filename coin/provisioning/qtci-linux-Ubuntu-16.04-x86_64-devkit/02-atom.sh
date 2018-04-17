#!/bin/bash -e

PKG_NAME=atom-1.25.1.deb
FILE=$HOME/Downloads/$PKG_NAME
wget -O $FILE https://atom.io/download/deb
sudo apt install gconf2 gconf-service gconf-service-backend
sudo dpkg -i $FILE
