#!/bin/bash

#Author: Ajay Kumar
#Date Created: 16.07.2024
#Last Modified: 17.07.2024


#Description
#This script sends email to the specified email address using 'mail' command

#Usage
#send_email.sh

#Check if mailutils package is installed or not

if dpkg -l | grep mailutils > /dev/null 2>&1; then
	echo -e "\nmailutils is installed."

else
	echo -e"\nmailutils not installed. Installing now...."
	sudo apt-get update
	sudo apt-get install mailutils -y
fi


echo -e "\nPlease enter the email ID/IDs"
read -a email_ids
echo -e "\n"
read -p "Please type the subject for the email:" mail_subject

#Choose whether to attach file or not to the email

read -p "Do you want to attach file/s to the email? (Y/N): " choice

if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
	read -p "Enter the filename or full path where the file is located:" file

	mail -s "$mail_subject" -A "$file" "${email_ids[@]}"
elif [ "$choice" = "N" ] || [ "$choice" = "n" ]; then
	mail -s "$mail_subject" "${email_ids[@]}"

else
	echo -e "Invalid choice! Please enter Y/y Or N/n"
fi

