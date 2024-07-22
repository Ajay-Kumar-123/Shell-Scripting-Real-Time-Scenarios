#!/bin/bash


#Author: Ajay Kumar
#Date Created: 22.07.2024
#Last Modified: 22.07.2024


#Description
#This script automates the process of updating a list of servers with the latest security patches.

#./update-servers.sh


servers=("15.206.201.213" "13.126.232.88" "13.232.231.168")

user="ubuntu"
key="/home/sandeep/Downloads/Chipsy/Aws_Sever_IPdoc_and_Keys/chipsy/ChipsyServiceApp.pem"
update_command="sudo apt-get update && sudo apt-get upgrade -y"

for server in "${servers[@]}"; do
	echo -e "\nUpdating $server........"
	ssh -i "$key" "$user"@"$server" "$update_command"
	if [ $? -eq 0 ]; then
		echo -e "\n$server updated successfully."
	else
		echo -e "Failed to update $server. Please try again"
	fi
done

echo -e "\nAll the servers updated."
