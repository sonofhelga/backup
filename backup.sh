#!/bin/bash

directories=('/boot' '/lib' '/etc' '/root' '/var' '/usr/local/bin' '/usr/local/sbin' '/srv' '/opt')
storage=('/home/loki/Storage/local_backup')


# simple copy function and list of directories
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

for i in "${directories[@]}" ;

do
	copy_dir $i ;

done

# directories that need exclusions applied
sudo rsync -av /home --exclude '/home/loki/.local/share/lutris' --exclude '/home/loki/.local/share/Steam'  --exclude '/home/loki/.cache' --exclude '/home/loki/.wine' --exclude '/home/loki/.lutris'--exclude '/home/loki/.local/share/lutris' --exclude '/home/loki/Games'  --exclude '/home/loki/Storage' $storage/local_backup/ ;


# create tar file and clean up
sudo tar -cvf $storage-$(date +"%m-%d").tar.zip $storage

sudo rm -rf /home/loki/Storage/local_backup-$(date +"%m-%d")
sudo rm -rf 

clear
echo "backup is finished."
