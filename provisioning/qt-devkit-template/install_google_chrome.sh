#!/bin/bash -e

# Install Coin development kit
# Author: Aapo Keskimolo <aapo.keskimolo@qt.io>

sudo apt install libgconf2-4 libnss3-1d libxss1
dpkg -i /srv/pkg/google-chrome-stable_current_amd64.deb
