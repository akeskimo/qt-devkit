#!/bin/bash -e

# Compress source files/directories defined in configuration file and upload them
# to a local directory or remote directory via ssh.

backup_config_file=~/.vmconfig/backup.conf
SCRIPT_PATH="`dirname \"$0\"`"
root=~  # root directory for the backup files
local_backup_dir=/tmp/devkit/backups

. $backup_config_file  # load backup configuration file

if [[ $1 == "source" ]]; then
 echo $backup_source_file:
 cat $backup_source_file
 exit 0
elif [[ $1 == "upload" ]]; then
 if [ -z $username ]; then
  echo "You must define 'username' variable in $backup_config_file"
  exit 1
 elif [ -z $server ]; then
  echo "You must define 'server' variable in $backup_config_file"
  exit 1
 elif [ -z $location ]; then
  echo "You must define 'location' variable in $backup_config_file"
  exit 1
 fi
elif [[ $1 == "list" ]]; then
 echo $username@$server:$location:
 ssh $username@$server "ls -l $location"
 exit 0
elif [[ $1 == "config" ]]; then
 echo $backup_config_file:
 cat $backup_config_file
 exit 0
elif [[ $1 == "restore" ]]; then
 backup_files=($(ssh $username@$server "ls $location"))
 echo "Choose backup to restore:"
 for f in $(seq 1 ${#backup_files[@]}); do
  idx=$(( $f - 1 ))
  echo $f. ${backup_files[$idx]}
 done
 printf "Choose file: "
 read file
 download_file=${backup_files[$(( $file - 1 ))]}
 scp $username@$server:$location/$download_file ~
 cd ~ && tar -xvf $download_file && rm ~/$download_file
 echo "Backup restored."
 exit 0
else
 echo "Accepted arguments: list, upload, source, restore"
 exit 1
fi

mkdir -p $local_backup_dir
filename=$(cat ~/TEMPLATE)-$(date +"%Y%m%d").tar.gz
tarfilepath=$local_backup_dir/$filename

cd $root

# skip files/folders that do not exist
tmp=
for f in $(cat $backup_source_file); do
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
scp $tarfilepath $username@$server:$destination_dir/

# inform user
echo "Backup uploaded:"
echo $tarfilepath "->" $username@$server:$location/$filename

# remove local backup file
rm $tarfilepath
