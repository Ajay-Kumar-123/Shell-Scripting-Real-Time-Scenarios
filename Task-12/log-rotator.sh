#!/bin/bash

#Author: Ajay Kumar
#Date Created: 22.07.2024
#Last Modified: 22.07.2024


#Description
#This script automates the process of rotating log files and compressing old files to save disk space.

#Usage
#./log-rotator.sh


read -p "Please enter the log file path:  " path
echo -e "\n"

read -p "Please enter the log file name:  " logfile
echo -e "\n"

#Check if logfile exits or not
if [ ! -f "$path/$logfile" ]; then
        echo -e "\nLog file does not exist!! Please enter the correct log file name."
else
	read -p "Please enter the archive directory path:  " archive_dir
	echo -e "\n"
	
	timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

	mv "$path/$logfile" "$archive_dir/$timestamp-$logfile"
	zip "$archive_dir/$timestamp-$logfile.zip" "$archive_dir/$timestamp-$logfile"
	rm "$archive_dir/$timestamp-$logfile"
	echo -e "\nLog rotation and compression completed..!!"
fi

