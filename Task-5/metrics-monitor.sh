#!/bin/bash

#Author: Ajay Kumar
#Date Created: 17.07.2024
#Last Modified: 17.07.2024


#Description
#This script monitors CPU, Memory, and Disk usage and sends the output to a file in table format and sends an alert if either of them exceeds a certain threshold.

#Usage
#metrics-monitor.sh


cpu_usage_threshold=40
memory_usage_threshold=40
disk_usage_threshold=40

csv_file=metrics-log.csv
header="Timestamp,CPU Usage,Memory Usage,Disk Usage"

if [ ! -s "$csv_file" ]; then
	echo "$header" > $csv_file
fi



#Check if mailutil utility is installed or not. If not install the same

if dpkg -l | grep mailutils >/dev/null 2>&1; then
	echo -e "\nmailutils utility installed"
else
	echo -e "\nmailutils utility not installed. Installing now....."
	sudo apt-get update --silent
	sudo apt-get install mailutils -y --silent
fi


#Function to send alert
function send_alert {
	local metric=$1
	local value=$2
	
	echo "Alert: $metric usage is at $value" | mail -s "System Alert: $metric Usage" ajay@chipsy.in
}



#Continuously monitor the system metrics and send alerts if either of the metrics exceed the threshold value
while true; do
	#Check the metrics
        time_stamp=$(date +"%Y-%m-%d_%H-%M-%S")

        cpu_usage=$(mpstat | awk 'NR==4 {print $4 "%"}')

        memory_usage=$(free -h | awk 'NR==2 {print int($3/$2*100) "%"}')

        disk_usage=$(df -h --total | tail -1 | awk '{print $5}')
        echo "$time_stamp,$cpu_usage,$memory_usage,$disk_usage" >> $csv_file

        echo -e "\nSystem metrics successfully saved to file"

	#Check if either of the metrics exceed threshold and send an alert
	if [ "$cpu_usage" > "$cpu_usage_threshold" ]; then
		send_alert "CPU" "$cpu_usage"
	fi
		
	if [ "$memory_usage" > "$memory_usage_threshold" ]; then
		send_alert "Memory" "$memory_usage"
	fi
		
	if [ "$disk_usage" > "$disk_usage_threshold" ]; then
		send_alert "Disk" "$disk_usage"
	fi

sleep 20
done
