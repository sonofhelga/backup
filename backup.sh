#!/bin/bash

# directories that will be copied
directories=('/boot' '/lib' '/etc' '/root' '/var' '/usr/local/bin' '/usr/local/sbin' '/srv' '/opt')

# where to save local backup
storage=('/home/loki/Storage/local_backup')

# simple copy function
function copy_dir(){
sudo rsync -av $1 $storage/
}


# make necessary directory @ storage location if not there already
if [ -d "$storage" ]
then
    echo "dir already exists."
else
    mkdir $storage
    sudo chown loki $storage
fi


# copying each entry from directories
for i in "${directories[@]}" ;

do
	copy_dir $i ;

done

# directories that need exclusions applied
sudo rsync -av /home --exclude '/home/loki/.local/share/lutris' --exclude '/home/loki/.local/share/Steam'  --exclude '/home/loki/.cache' --exclude '/home/loki/.wine' --exclude '/home/loki/.lutris'--exclude '/home/loki/.local/share/lutris' --exclude '/home/loki/Games'  --exclude '/home/loki/Storage' $storage/local_backup/ ;


# create tar file from updated backup
sudo tar -cvf $storage-$(date +"%m-%d").tar.zip $storage

clear
echo "backup is finished."
