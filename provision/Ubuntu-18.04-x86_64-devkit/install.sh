#!/bin/bash -e

# install packages for development

# update packages
sudo add-apt-repository universe
sudo apt -y upgrade
sudo apt -y update

# coin packages
sudo apt install -y nodejs npm python3-dev python3-sphinx cmake \
                    pkg-config flex bison tmux zip pigz p7zip-full \
                    python3-pip

# install python pip and pipenv
python3 -m pip install --user pip setuptools
echo "export PATH=\$PATH:~/.local/bin" >> ~/.bashrc
python3 -m pip install --user pipenv

# utilities
sudo apt install -y cifs-utils screen quassel terminator

# qtcreator, documentation and examples
sudo apt install -y build-essential qtcreator qt5-default
sudo apt install -y qt5-doc qt5-doc-html qtbase5-doc-html qtbase5-examples
