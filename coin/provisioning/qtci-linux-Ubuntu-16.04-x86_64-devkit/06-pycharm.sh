#!/bin/bash -e

cd $HOME/Downloads

# installs on opt and changes file permissions
PYCHARM_VERSION=pycharm-edu-4.0
PYCHARM_PATH=/opt/$PYCHARM_VERSION

wget https://download.jetbrains.com/python/$PYCHARM_VERSION.tar.gz
sudo mkdir -p $PYCHARM_PATH && sudo chown qt:users $PYCHARM_PATH -R
tar -xvf $PYCHARM_VERSION.tar.gz -C /opt/

