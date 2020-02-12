#!/bin/bash -e

# print alias for syncing source files to remote directory

if [ $# -eq 2 ]; then
 source=$1
 if [[ ! $source = /* ]] || [ ! -d $source ]; then
   echo "Source $source should be absolute directory"
 fi
 destination=$2
else
 echo "The script requires exactly 2 input arguments, eg.

   ./install_alias.sh /abs/path/to/directory/to/sync username@server:/abs/path/to/remote/target/dir
"
 exit 1
fi

curdir=$(dirname $(readlink -f "$0"))
alias_name=sync-remote

args=--delete
ignore_filepath=$curdir/$(basename $source).ignore
if [ -f $ignore_filepath ]; then
 args="$args --exclude-from $curdir/$(basename $source).ignore"
else
 echo "No ignore file $ignore_filepath found. All source files will be synced."
fi

echo alias $alias_name=\"rsync -av $args $source $destination\"
