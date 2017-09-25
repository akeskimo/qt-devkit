#!/bin/bash -e

# Clone devkit project repositories from Gerrit
# Author: Aapo Keskimolo <aapo.keskimolo@qt.io>

SCRIPT_PATH="`dirname \"$0\"`"

root=~/repos  # destination of the cloned repositories
repo_srcfile=~/.vmconfig/qtprojects  # source file that contains list of qt-projects

mkdir -p $root

for repo in $(cat $repo_srcfile); do
    destination=$root/$repo
    if [ ! -d "$destination" ]; then
        git clone ssh://codereview.qt-project.org:29418/$repo $destination
        if [ $repo == "qt/qt5" ]; then
           cd $destination && git submodule update --init && cd $root
        fi
    else
        echo "Directory $destination already exists. Skipped."
    fi
done
