#!/bin/bash -e

# Compress source files/directories defined in configuration file and upload them
# to a local directory or remote directory via ssh.
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
tarfile=$(cat ~/TEMPLATE)-$(date +"%Y%m%d").tar.gz
tarfilepath=$local_backup_dir/$tarfile

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

# copy tarfile to backup directory
scp $tarfilepath $destination/

# inform user
echo "Backup created:" $tarfilepath "->" $destination/$tarfile

# remove local backup file
rm $tarfilepath
