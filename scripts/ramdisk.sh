#!/bin/bash
# ramdisk management script
LOCATION=/ramdisk
SIZE=8192M
BACKUPDIR=~/TARGETS/BACKUPS/data-`date +%F-%H%M%S`

if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root." 
   exit 1
fi

if [ $1 == "create" ]; then
  mkdir -p $LOCATION
  mount -t tmpfs -o size=$SIZE tmpfs $LOCATION
else if [ $1 == "destroy" ]; then
  sudo umount $LOCATION
else if [ $1 == "backup" ]; then
  cp -ru $LOCATION $BACKUPDIR
else if [ $1 == "persist" ]; then
  echo "none $LOCATION tmpfs nodev,nosuid,noexec,nodiratime,size=$SIZE 0 0" >> /etc/fstab
else
  echo "Usage: $0 <create|destroy|backup|persist>"
fi

