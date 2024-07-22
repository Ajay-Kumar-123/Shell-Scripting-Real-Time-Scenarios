#!/bin/bash

#Author: Ajay Kumar
#Date Created: 21.07.2024
#Last Modified: 21.07.2024


#Description
#This script parses a log file and forwards a specific value with a timestamp to an output file.

#Usage
#./logfile-parser.sh


#Specify log file path 
read -p "Please specify the log file path:  " logfile
echo -e "\n"

#Check if the logfile exists or not
if [ ! -f "$logfile" ]; then
	echo -e "\nLog file does not exist"
	exit 1
fi

#Specify the string to be extracted from the log file
read -p "Please specify the 1st variant of the string to be extracted from the log file:  " string1
echo -e "\n"

read -p "Please specify the 2nd variant of the string to be extracted from the log file:  " string2

grep -E -i "$string1|$string2" "$logfile" | while read -r line; do
	value=$(echo "$line" | grep -E -i -o "$string1|$string2")
        timestamp=$(echo "$line" | awk '{print $1 "\t" $2 "\t" $3"\t"}')
	echo "$timestamp" "$value" >> logfile-parser.txt
done
		
