#!/bin/bash -e

# Clean up user-specific information
# Author: Aapo Keskimolo <aapo.keskimolo@qt.io>

rm $HOME/.ssh/id_rsa* && rm $HOME/.ssh/config
git config --global --unset-all user.name
git config --global --unset-all user.email
cp /srv/share/sync2vm/config $HOME/sync2vm/config
cp /srv/share/.gitconfig $HOME/.gitconfig
