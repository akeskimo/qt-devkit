#!/bin/bash -e

sudo apt upgrade
sudo apt update
sudo add-apt-repository universe

sudo apt install -y nodejs npm  virtualenv python3-dev python3-pip \
            python-sphinx cmake pkg-config flex bison tmux zip pigz \
            p7zip-full kcachegrind openconnect

sudo apt install -y cifs-utils screen

sudo apt install inotify-tools

# qtcreator, documentation and examples
sudo apt install -y build-essential qtcreator qt5-default
sudo apt install -y qt5-doc qt5-doc-html qtbase5-doc-html qtbase5-examples
