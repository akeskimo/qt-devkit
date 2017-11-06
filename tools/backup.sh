#!/bin/bash -e

# Compress source files/directories defined in configuration file and upload them
# to a local directory or ssh destination.
# Examples:
# ./backup.sh username@server:remote-directory/
# ./backup.sh local-directory/

if [ ! -z $1 ]; then
 destination=$1
else
 echo "ERROR: You must provide the backup destination as first input argument"
 exit 1
fi

SCRIPT_PATH="`dirname \"$0\"`"

root=~  # root directory from where the relative paths start
backup_src=~/.vmconfig/backup
local_backup_dir=/tmp/devkit/backups
mkdir -p $local_backup_dir
tarfilepath=$local_backup_dir/$(cat ~/TEMPLATE)-$(date +"%Y%m%d").tar.gz

cd $root

# skip files/folders that do not exist
tmp=
for f in $(cat $backup_src); do
 if [ ! -f $f ] && [ ! -d $f ]; then
  echo "WARNING: Directory or file $root/$f does not exist."
 else
  tmp="$tmp $f"
 fi
done
backup_files=$tmp

# create tar file of the backup directories/files
tar -cPf $tarfilepath $backup_files

# use rsync to upload (all) local backups to remote server
rsync -au $local_backup_dir $destination

echo "New backup:" $tarfilepath "->" $destination
