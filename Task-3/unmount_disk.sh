#!/bin/bash

#Author: Ajay Kumar
#Date Created: 16.07.2024
#Last Modified: 16.07.2024


#Description
#This script gracefully unmounts a disk based on user selection


echo -e "\nList of mounted disks on this server:"
lsblk -o NAME,MOUNTPOINTS | grep -v "MOUNTPOINTS" | grep -v "─" 

#grep -v "MOUNTPOINTS" - Excludes all the lines that contains MOUNTPOINTS. It will be usually in the 1st line
#grep -v "─" - Excludes all the lines that are partitions of a disk
#Ex:
#NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
#sda      8:0    0   50G  0 disk
#├─sda1   8:1    0   50G  0 part /   -----> Excludes this line



read -r -p "Please enter the disk to be unmounted:" disk

echo -e "\nUnmounting disk $disk...."
sudo umount /dev/"$disk"

#Verify disk is unmounted
if mount | grep "/dev/$disk" > /dev/null; then
	echo -e "/nError: Failed to unmount $disk"
else
	echo -e "/nSuccessfully unmounted $disk"
fi
