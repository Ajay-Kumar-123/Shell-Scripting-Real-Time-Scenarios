#!/bin/bash


#Author: Ajay Kumar
#Date Created: 18.07.2024
#Last Modified: 18.07.2024


# Description
# This script demonstrates a user management application that performs appropriate actions viz create a user,
# delete a user, reset password, list users and help option to provide script usage details based on the options selected


#Usage
#user-managemnt.sh [OPTIONS]


#Check if any argument is passed or not and display script usage

function display_usage {
	echo -e "\nUsage: $0 [OPTIONS]"
	echo -e "\nOptions: "
	   echo -e "\n-c, --create		Create a new user account"
	   echo -e "-d, --delete		Delete an existing user account"
	   echo -e "-r, --reset		Reset password of an existing user account"
	   echo -e "-l, --list		List all the user accounts"
	   echo -e "-h, --help		List this help menu and exit"
}


if [ "$#" -eq 0 ] || [ -z "$1" ] || [ "$1" = "--h" ] || [ "$1" = "--help" ]; then
	display_usage
	exit 1;
fi


#Create user function
function create_user {
	read -p "Enter the new user name:  " user_name
	#Check if user already exists
	if id "$user_name" &>/dev/null; then
		echo -e "\nError: User name $user_name already exists!! Please enter a unique user name"
	else
		read -s -p "Please enter the password for $user_name :  " password
		sudo useradd -m -p "$password" "$user_name"
		echo -e "\nUser account $user_name successfully created."
	fi
}


#Delete user function
function delete_user {
	read -p "Enter the user name to be deleted:  " user_name
	if id "$user_name" &>/dev/null; then
		sudo userdel -r "$user_name" &>/dev/null
	echo -e "\nUser account $user_name successfully deleted."

        else
		echo -e "\nError: User account $user_name does not exist! Please enter a valid user name."
	fi
}


#Reset password function
function reset_password {
	read -p "Enter the user name to reset the password:  " user_name
	if id "$user_name" &>/dev/null; then
		read -s -p "Enter the new password for $user_name:  " password
		echo "$user_name":"$password" | sudo chpasswd
		echo -e "\nPassword for $user_name reset successfully."
	else
		echo -e "\nError: User account $user_name does not exist! Please enter a valid user name."
	fi

}


#List users function
function list_users {
	echo -e "\nList of user accounts on the server:"
	echo -e "============================================================="
	sudo cat /etc/passwd | awk -F : '{print "- " $1 "\t\t(UID: $3)"}'
}


#Execute all the functions in a loop
while [ "$#" -gt 0 ]; do
	case "$1" in
		-c|--create) create_user;;
		-d|--delete) delete_user;;
		-r|--reset) reset_password;;
		-l|--list) list_users;;
		-h|--help) display_usage;;
		*) echo -e "\nError: Invalid option '$1'. Use -h or --help to see available options."
		   exit 1;;
	esac
	shift
done
