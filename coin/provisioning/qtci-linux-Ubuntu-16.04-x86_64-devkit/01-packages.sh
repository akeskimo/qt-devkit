#!/bin/bash -e

# install packages for development

# update packages
sudo add-apt-repository universe
sudo apt upgrade
sudo apt update

# coin dependencies
sudo apt install -y nodejs npm  virtualenv python3-dev python3-pip \
            python-sphinx cmake pkg-config flex bison tmux zip pigz \
            p7zip-full kcachegrind openconnect
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
