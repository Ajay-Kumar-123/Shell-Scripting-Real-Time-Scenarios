#!/bin/bash

#Author: Ajay Kumar
#Date Created: 15.07.2024
#Last Modified: 15.07.2024

#Description
#This script lists processes that exceed certain CPU and Memory usage and allows the user to kill the processes


#Usage
#kill_unwanted_process.sh cpu_percentage

cpu_usage="$1"

function display_usage {
	echo "$0 cpu_percentage"
}

if [ $# -eq 0 ] || [ -z $1 ]; then
	echo -e "\nEnter atleast 1 argument"
	display_usage
	exit 1
fi

function find_processes {
	top -b -n 1 | awk 'NR>7 {if($9 > $cpu_usage) print $1"-"$12}'
}

find_processes

echo -e "\nEnter the process ids of the processes to be killed:"
read -a process_ids #Stores the process IDs in an array.Enter a space in between the process IDs

echo -e "\nProcess IDs stored"
echo "${process_ids[@]}"

for process_id in "${process_ids[@]}"; do
	kill $process_id
done

echo -e "\nUnwanted processes killed!!"
