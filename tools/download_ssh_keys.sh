#!/bin/bash -e

# Provision VM with user specific information

if [ -z "$1" ]; then
    echo "You must give server address as input argument, eg: 10.212.3.36"
    exit 1
fi

if [ -z "$2" ]; then
   echo "You must give ssh username, eg: aakeskim"
   exit 1
fi

server=$1
username=$2
scp $username@$server:/home/$username/.ssh/id_rsa* ~/.ssh/
scp $username@$server:/home/$username/.ssh/config* ~/.ssh/

