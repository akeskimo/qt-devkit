#!/bin/bash -e

# Download setup files from remote
# Author: Aapo Keskimolo <aapo.keskimolo@qt.io>

if [ -z "$1" ]; then
    echo "You must give ssh server address as input argument, eg: 10.212.3.36."
    exit 1
fi

if [ -z "$2" ]; then
   echo "You must give ssh username as input argument."
   exit 1
fi

server=$1
username=$2

scp $username@$server:/home/$username/Downloads/* $HOME/Downloads/
scp $username@$server::/srv/pkg/* /srv/pkg/
