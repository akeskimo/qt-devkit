#!/bin/bash -e

# Clean up SSH and user-specific information
# Author: Aapo Keskimolo <aapo.keskimolo@qt.io>

rm $HOME/.ssh/id_rsa* && rm $HOME/.ssh/config
git config --global --unset-all user.name
git config --global --unset-all user.email
cp /srv/share/sync-to-remote/config $HOME/sync-to-remote/config
cp /srv/share/.gitconfig $HOME/.gitconfig
