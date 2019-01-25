#!/bin/bash -e

# install go version in home directory and add required environment variables

if [ -z "$1" ]; then
 echo "First input should be go version, eg. 1.10.1"
 exit 1
fi

GO_VERSION=go$1.linux-amd64
GO_INSTALL_PATH=$HOME/go
FILE=$HOME/Downloads/$GO_VERSION.tar.gz
wget -O $FILE https://dl.google.com/go/$GO_VERSION.tar.gz
rm -rf $GO_INSTALL_PATH
tar -xvf $FILE -C $HOME/
rm $FILE

# add to bash for startup
echo "export PATH=\$PATH:$GO_INSTALL_PATH/bin" >> $HOME/.bashrc
echo "export GOROOT=$GO_INSTALL_PATH" >> $HOME/.bashrc
