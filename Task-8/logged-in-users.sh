#!/bin/bash

#Author: Ajay Kumar
#Date Created: 19.07.2024
#Last Modified: 19.07.2024


#Description
#This script lists all the users logged in by date and stores the output in a file


#Usage
#logged-in-users.sh

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
echo -e "\n==========================================================" >> logged-in-users.log
echo "Currently logged in users as at $timestamp" >> logged-in-users.log
echo "==========================================================" >> logged-in-users.log
#List currently logged in users
who | awk '{print $1" \t"$3"\t"$4}' >> logged-in-users.log


#List currently logged in users as well as previously logged in users
#last



