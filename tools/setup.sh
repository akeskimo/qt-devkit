#!/bin/bash -e

# Setup VM for first time use
# Author: Aapo Keskimolo <aapo.keskimolo@qt.io>

SCRIPT_PATH="`dirname \"$0\"`"

function download_ssh_config_from_server() {
 # Download ssh keys and config from remote server via SSH
 # $1 ~ SSH server address
 # $2 ~ SSH server username
 $SCRIPT_PATH/download_ssh_keys.sh $1 $2
}

function update_git_config() {
 # Updates global git configuration
 # $1 ~ Gerrit/Git user's full name
 # $2 ~ Gerrit/Git user's email
 # Template https://wiki.qt.io/Setting_up_Gerrit (Last update: 2017-Aug-24)

 # enable CRLF line endings
 git config --global core.autocrlf input

 # set gerrit user information
 git config --global user.name "$1"
 git config --global user.email "$2"

 # always show untracked files in git status/commit
 git config --global status.showuntrackedfiles all

 # push only current branch
 git config --global push.default tracking

 # replay conflict resolutions
 git config --global rerere.enabled true
 git config --global rerere.autoupdate true

 # enable diff stat overview for git pull--rebase
 git config --global rebase.stat true

 # set color schema for git diff/log/show
 git config --global color.ui auto
 git config --global core.pager "less -FRSX"

 # enable global git template
 git config --global commit.template $HOME/repos/qt/qt5/.commit-template

 # set git aliases
 git config --global alias.di diff
 git config --global alias.ci commit
 git config --global alias.co checkout
 git config --global alias.ann blame
 git config --global alias.st status
}

function update_sync_to_remote() {
 # Sets up sync-to-remote via SSH/rsync
 string="s/username/$1/g"
 sed -i $string $HOME/sync2vm/config
}


######## MAIN #########

# update git global config
echo "Give your full name for Gerrit/Git (eg. John Doe) >> "
read name
echo "Give your user email for Gerrit/Git (eg. john.doe@qt.io) >> "
read email
if [ ! -z "$name" ] || [ ! -z "$email" ]; then
 update_git_config "$name" "$email"
 echo "Updating .gitconfig finished."
else
 echo "No valid user info provided. Git configuration skipped."
fi

# download ssh keys
echo "Enter SSH server address from where to download private/public SSH keys (eg. 10.212.3.36 or press enter to skip) >> "
read server
if [ ! -z $server ]; then
 echo "Your username to login to $server >> "
 read username
fi
if [ ! -z $server ] && [ ! -z $username ]; then
 download_ssh_config_from_server "$server" "$username"
 echo "SSH key and config download finished."
 # update sync-to-remote
 update_sync_to_remote "$username"
 echo "Updating sync-to-remote config file finished."
else
 echo "No valid SSH information provided. Downloading ssh keys skipped."
fi
