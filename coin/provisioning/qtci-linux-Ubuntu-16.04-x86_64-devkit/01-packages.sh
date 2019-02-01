#!/bin/bash -e

# install packages for development

# update packages
sudo add-apt-repository universe
sudo apt upgrade
sudo apt update

# coin dependencies
sudo apt install -y nodejs npm python3-dev python3-sphinx cmake \
                    pkg-config flex bison tmux zip pigz p7zip-full
                    python3-pip
python3 -m pip install --user pip setuptools
echo "export PATH=\$PATH:~/.local/bin" >> ~/.bashrc
python3 -m pip install --user pipenv

# screen
sudo apt install -y cifs-utils screen

# inotify
sudo apt install -y inotify-tools

# quassel irc
sudo apt install -y quassel

# qtcreator, documentation and examples
sudo apt install -y build-essential qtcreator qt5-default
sudo apt install -y qt5-doc qt5-doc-html qtbase5-doc-html qtbase5-examples

# terminator
sudo apt -y install terminator

# go
GO_VERSION=go1.10.1.linux-amd64
GO_INSTALL_PATH=$HOME/go
FILE=$HOME/Downloads/$GO_VERSION.tar.gz
wget -O $FILE https://dl.google.com/go/$GO_VERSION.tar.gz
rm -rf $GO_INSTALL_PATH
tar -xvf $FILE -C $HOME/
rm $FILE
echo "export PATH=\$PATH:$GO_INSTALL_PATH/bin" >> $HOME/.bashrc
echo "export GOROOT=$GO_INSTALL_PATH" >> $HOME/.bashrc

# vscode
PKG_NAME=code_1.22.2-1523551015_amd64.deb
FILE=$HOME/Downloads/$PKG_NAME
wget -O $FILE https://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install gconf2-common libgconf-2-4
sudo dpkg -i $FILE
# enable watching large amount of files
sudo echo fs.inotify.max_user_watches=524288 >> /etc/sysctl.conf
sudo sysctl -p
