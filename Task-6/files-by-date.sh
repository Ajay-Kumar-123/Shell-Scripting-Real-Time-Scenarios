#!/bin/bash


#Author: Ajay Kumar
#Date Created: 18.07.2024
#Last Modified: 18.07.2024


#Description
#This script finds the files created and their sizes. It should accept the number of days as input. Or a from and to date format as inputs.

#Usage
#files-by-date.sh

echo -e "\n==================================================="
echo -e "\n\t**********<<File Finder>>**********"
echo -e "\n==================================================="

read -p "Do you want to enter the Number of Days (N) or From and To Dates (FT) ? Select N/n or FT/ft " choice
echo -e "\n"

if [ "$choice" = "N" ] || [ "$choice" = "n" ]; then
	read -p "Please enter the number of days: " days

	echo -e "\nThe files created since the last $days days are: "
	echo -e "\n======================================================================================================================"
	sudo find / -type f -mtime "$days" -exec ls -lth {} + 2>/dev/null | awk '{print $9 "\t\t\t" $5}'
#If we want to find the files created more than the number of days specified, we use -mtime -"$days"
#If we want to find the files creatd less than the number of days specified, we use -mtime +"$days"

elif [ "$choice" = "FT" ] || [ "$choice" = "ft" ]; then
	read -p "Please enter the from date (YYYY-MM-DD): " from_date
	echo -e "\n"
	read -p "Please enter the to date (YYYY-MM-DD): " to_date
        echo -e "\nThe files created between $from_date and $to_date are: "
	echo -e "\n======================================================================================================================"
	sudo find / -type f -newermt "$from_date" ! -newermt "$to_date" -exec ls -lh {} + 2>/dev/null | awk '{print $9 "\t\t\t" $5}'
fi



