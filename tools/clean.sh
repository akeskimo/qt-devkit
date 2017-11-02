#!/bin/bash -e

# Clean up user-specific information

rm -f ~/.ssh/id_rsa* && rm -f ~/.ssh/config
git config --global --unset-all user.name
git config --global --unset-all user.email
cp /srv/share/sync2vm/config ~/qt-devkit/sync2vm/config
cp /srv/share/.gitconfig ~/.gitconfig
