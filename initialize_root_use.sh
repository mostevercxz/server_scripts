#!/bin/bash
#Usage : ./initialize.sh userNameXXX
#Desc  : the script must be running as root, for adding a user named userNameXXX

# Check if running as root
if [ "$(id -u)" != "0" ]; then
	echo "You must run this script as root"
	exit 1
fi

# Check arguments
if [ $1 ]; then
	echo "--- Ready to create user :"$1
else
	echo "You are Wrong"
	echo "Usage : . ./initialize.sh userNameXXX"
	exit 1
fi

# 1. executed by root, creat a user,first check if the user already exists(check /home/userNameXXX directory)
if [ -d /home/$1 ]; 
then
	echo "User "$1"already eists, go on"
else
	adduser $1
fi
echo "--- Finish creating user :"$1
echo " "

# 2.executed by root, install some commonly used packages
echo "--- Ready to install Packages"
sudo apt-get install python-virtualenv git -y
echo "--- Finish installing Packages"
