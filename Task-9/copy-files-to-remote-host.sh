#!/bin/bash


#Author: Ajay Kumar
#Date Created: 19.07.2024
#Last Modified: 19.07.2024


#Description
#This script recursively copies files to specified remote host


#Usage
#copy-files-to-remote-host.sh [file_path]

echo -e "\nWelcome! $USER"
echo -e "\n"

read -p "Please enter the remote server hostname:  " hostname
echo -e "\n"

read -p "Please enter the IP address of the remote server: " ip_address
echo -e "\n"

read -p "Please enter the file path to be copied to the remote host:  " filepath
echo -e "\n"

read -p "Please enter the pem key / private key path:  " private_key
echo -e "\n"

read -p "Please enter remote host directory path:  " remote_host_directory

echo -e "\nCopying files to the remote host...."

scp -i "$private_key" -r "$filepath" "$hostname@$ip_address":"$remote_host_directory"

#Check if file copy was successful
if [ $? -eq 0 ]; then
	echo -e "\nFiles copied succesfully!!"
else
	echo -e "\nError occured during file copy!!"
fi


