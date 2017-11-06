#!/bin/bash -e

# Add new sudo user

if [ -z "$1" ]; then
 echo "You must give user name as input argument."
 exit 1
fi

username=$1

sudo adduser $username
sudo adduser $username sudo
sudo chsh $username -s /bin/bash  # sets bash as default shell environment
sudo chown $username:$username /home/$username -R
