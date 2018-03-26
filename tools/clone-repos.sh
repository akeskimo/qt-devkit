#!/bin/bash -e

# Clone devkit project repositories from Gerrit

SCRIPT_PATH="`dirname \"$0\"`"
root=~/repos  # destination of the cloned repositories
repos_file=~/.vmconfig/repos  # source file that contains list of qt-projects

mkdir -p $root

for repo in $(cat $repos_file); do
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
