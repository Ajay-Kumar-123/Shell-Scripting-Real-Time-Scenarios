#!/bin/bash


#Author: Ajay Kumar
#Date Created: 16.07.2024
#Last Modified: 16.07.2024


#Description
#This script prints the 10 biggest files in the system and prints the output to a file

#Usage
#first-10-biggest-files.sh

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

echo -e "\n==============================================================================================================================" >> biggest-files.txt
echo -e "\nThe 10 biggest files as on $timestamp are: " >> biggest-files.txt
echo -e "\n==============================================================================================================================" >> biggest-files.txt
sudo find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10 >> biggest-files.txt

echo -e "\n==============================================================================================================================" >> biggest-files.txt

echo -e "\nList of 10 biggest files saved to the file biggest-files.txt"


