#!/bin/bash

#Author: Ajay Kumar
#Date Created: 22.07.2024
#Last Modified: 22.07.2024


#Description
#This script checks the status of a list of URLs and sends an email notification if any of them are down.

#Usage
#./url-checker.sh


urls=("https://trainwithshubham.com" "https://chipsyservices.com" "https://www.oracle.com")

#Prepare the email subject and body
email_id="ajay@chipsy.in"
email_subject="URL Down Alert"
email_body="The following URLs are down:\n"

#Check if mailutils package is installed or not
if dpkg -l | grep mailutils; then
	echo -e "\nmailutils package already installed. Emails can be sent"
else
	echo -e "\nmailutils package not installed. Installing...."
	sudo apt-get update > /dev/null 2>&1
	sudo apt-get install mailutils
fi

#Check the status of the URLs
for url in "${urls[@]}"; do
	status=$(curl -Is "$url" | awk 'NR==1 {print $2}')
	
	if [ "$status" -ge 400 ]; then
	email_body+="$url returned status code $status\n"
	fi
done

#Send the notification via email
echo "$email_body" | mail -s "$email_subject" "$email_id"

#Check if mail was sent successfully
if [ $? -ne 0 ]; then
	echo -e "\nFailed to send email alert"
else
	echo -e "\nEmail alert sent"
fi
