#!/bin/bash -e

PKG_NAME=code_1.22.2-1523551015_amd64.deb
FILE=$HOME/Downloads/$PKG_NAME
wget -O $FILE https://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install gconf2-common libgconf-2-4
sudo dpkg -i $FILE
