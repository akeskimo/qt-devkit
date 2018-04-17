#!/bin/bash -e

rm -f ~/.ssh/id_rsa* && rm -f ~/.ssh/config
rm -f ~/.bash_history
git config --global --unset-all user.name
git config --global --unset-all user.email
