#!/bin/bash -e

GO_VERSION=go1.10.1.linux-amd64
GO_INSTALL_PATH=$HOME/go
FILE=$HOME/Downloads/$GO_VERSION.tar.gz
wget -O $FILE https://dl.google.com/go/$GO_VERSION.tar.gz
tar -xvf $FILE -C $HOME/

# add to bash startup
./add_line_to_bashrc.sh "export PATH=\$PATH:$GO_INSTALL_PATH/bin"
./add_line_to_bashrc.sh "export GOROOT=$GO_INSTALL_PATH"
