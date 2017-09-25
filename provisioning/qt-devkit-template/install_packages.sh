#!/bin/bash -e

# Install packages
# Author: Aapo Keskimolo <aapo.keskimolo@qt.io>

# Coin development kit (updated: 24-August-2017)
sudo apt install -y nodejs nodejs-legacy npm \
            virtualenv python3-dev python3-pip python3-sphinx \
            cmake pkg-config flex bison tmux zip pigz p7zip-full

# Quassel core client
sudo apt install -y quassel
