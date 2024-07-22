#!/bin/bash


#Author: Ajay Kumar
#Date Created: 19.07.2024
#Last Modified: 19.07.2024


#Description
#This script displays the number of failed login attempts by IP address and location.

#Usage
#./failed-logins.sh


#Check if geoip-bin utility is installed or not
if dpkg -l | grep geoip-bin > /dev/null 2>&1; then 
	echo -e "\ngeoip-bin utility is installed. Proceeding with parsing the log file for failed logins"
else
	echo -e "\ngeoip-bin utility is not installed. Installing geoip-bin utility...."
	sudo apt-get update
	sudo apt-get install geoip-bin -y
fi

logfile_path="/var/log/auth.log"
	
#Parse the log file for failed logins
grep -i -E "Failed password|Failure" "$logfile_path" | awk '{print $10}' | sort | uniq -c >> failed-logins.txt

while read -r line; do
	count=$(echo "$line" | awk '{print $1}')
	ip=$(echo "$line" | awk '{print $2}')
	location=$(geoiplookup "$ip" | awk '{print $4" "$5}')

	echo -e "\n$count failed attempts from $ip, $location"
done < failed-logins.txt

#Clean Up
rm failed-logins.txt


#Output:
#geoip-bin utility is installed. Proceeding with parsing the log file for failed logins

#1 failed attempt/s from 121.158.206.151, KR, Korea,

#1 failed attempt/s from 14.34.248.108, KR, Korea,

#1 failed attempt/s from 168.126.179.21, KR, Korea,

#1 failed attempt/s from 211.229.98.228, KR, Korea,

#6 failed attempt/s from 222.108.85.243, KR, Korea,

#21 failed attempt/s from 79.184.222.222, PL, Poland
