#!/bin/bash -e

cd $HOME/Downloads

GO_VERSION=go1.8.3.linux-amd64
GO_INSTALL_PATH=$HOME/go 
FILE=/srv/pkg/$GO_VERSION.tar.gz
mkdir -p $GO_INSTALL_PATH
tar -xvf $FILE -C /home/qt/

# add to bash startup
./../bin/add_line_to_bashrc.sh "export PATH=\$PATH:$GO_INSTALL_PATH/bin"
./../bin/add_line_to_bashrc.sh "export GOROOT=$GO_INSTALL_PATH"
