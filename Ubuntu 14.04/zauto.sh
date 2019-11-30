#! /bin/bash
#Author: Imagine Virt [12-3253], OATS 
#Title: WCTA Cyberpatriot Script, Linux 

#Variables
PWDt=$(pwd)

#Startup
echo "$(date +'%m/%d/%Y %r'): Verifying an internet connection with aptitude"
echo "$(date +'%m/%d/%Y %r'): Verifying an internet connection with aptitude" >> $PWDt/log/logger.log
apt-get install cowsay -y &> /dev/null
if [ "$?" -eq "1" ]; then
   echo "$(date +'%m/%d/%Y %r'): This script cannot access aptitude properly."
   echo "$(date +'%m/%d/%Y %r'): Apititude check failed" >> $PWDt/log/logger.log
   exit 1
fi
unalias -a
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
echo "$(date +'%m/%d/%Y %r'): Starting script" >> $PWDt/log/logger.log

if ! [ -d $PWDt/config ]; then
	echo "$(date +'%m/%d/%Y %r'): Please Cd into cyberpat directory and run the script there."
	echo "$(date +'%m/%d/%Y %r'): Please Cd into cyberpat directory and run the script there." >> $PWDt/log/logger.log
	exit
fi

if [ "$EUID" -ne 0 ]; then
	echo "$(date +'%m/%d/%Y %r'): Run as Root" 
	echo "$(date +'%m/%d/%Y %r'): Run as Root" >> $PWDt/log/logger.log
	exit
fi

## Functions ##

#Updates 
aptf() {
 echo "Updating System"
  echo "$(date +'%m/%d/%Y %r'): Updating System" >> $PWDt/log/logger.log
    sudo apt-get upgrade
    sudo apt-get update
   stop
}

#Remove 
erase() {
 echo "Removing Apps, Media, and Services"
  echo "$(date +'%m/%d/%Y %r'): Removing Apps, Media, and Services" >> $PWDt/log/logger.log
   sudo ./script/purge.sh 
  stop
}

#Firewall
fire() {
 echo "Hardening the firewall"
  echo "$(date +'%m/%d/%Y %r'): Updating Firewall" >> $PWDt/log/logger.log
   sudo ./script/firewall.sh
  stop
}

#Passwd Policies
passif() {
 echo "Updating Password Policies"
  echo "$(date +'%m/%d/%Y %r'): Updating Password Policies" >> $PWDt/log/logger.log
   sudo ./script/firewall.sh
  stop
}

#UID root check
zeroUid() {
 echo "Checking for 0Uid"
  echo "$(date +'%m/%d/%Y %r'): Checking for Root Users" >> $PWDt/log/logger.log
  sudo ./script/zeroUid.sh
 stop
}

#Users Accounts
usersif() {
 echo "Adding, Removing, or Promoting User Accounts"
  echo "$(date +'%m/%d/%Y %r'): Adding, Removing, or Promoting User Accounts" >> $PWDt/log/logger.log
 echo "Copy the README users into the txt file"
  sudo ./script/users.sh
 stop
}

#Account Policy
accountif() {
 echo "Changing User Account Policies"
  echo "$(date +'%m/%d/%Y %r'): Changing User Account Policies" >> $PWDt/log/logger.log
   sudo ./script/account.sh
  stop
}

menu() {
	clear
	echo "
    ____                   ____        _       __ 
   / __ \___  ___ ___     / __/_______(_)__   / /_
  / /_/ / _ \/ -_) _ \   _\ \/ __/ __/ / _ \ / __/
  \____/ .__/\__/_//_/  /___/\__/_/ /_/ .__/ \__/ 
      /_/                            /_/         
"
	echo "------------------"
	echo " M A I N _ M E N U"
	echo "------------------"
	echo "1) Updates System"				#aptf
	echo "2) Purges Media, Services, Apps"			#erase
	echo "3) Updates the Firewall"				#fire
	echo "4) Updates Passwd Policies users"			#passif
	echo "5) Check for UID's of 0 (Root Access Acounts)"	#zeroUid
	echo "6) Add, Remove, or Promotes User Accounts" 	#usersif
	echo "7) User Account Policies" 			#accountif
	echo "8) Go to Logs"
	echo "9) Exit"
}

stop() {
	echo "Continue? (Y/N) "
	read continu
	if [ "$continu" = "N" ] || [ "$continu" = "n" ]; then
		echo "$(date +'%m/%d/%Y %r'): Ending script"
		echo "$(date +'%m/%d/%Y %r'): Ending script" >> $PWDt/log/logger.log
		exit;
	fi
}

read_choice() {
	read -p "Enter choice 1-9: "
	if  [ $REPLY == "1" ]; then
		aptf;

	elif [ $REPLY == "2" ]; then
		erase;
	
	elif [ $REPLY == "3" ]; then
		fire;

	elif [ $REPLY == "4" ]; then
		passif;

	elif [ $REPLY == "5" ]; then
		zeroUid;
		
	elif [ $REPLY == "6" ]; then
		usersif;
		
	elif [ $REPLY == "7" ]; then
		accountif;
		
	elif [ $REPLY == "8" ]; then
		gedit $PWDt/log/logger.log

	elif [ $REPLY == "9" ]; then
		echo "$(date +'%m/%d/%Y %r'): Ending script"
		echo "$(date +'%m/%d/%Y %r'): Ending script" >> $PWDt/log/logger.log
		exit 0;

	fi
}

trap '' SIGINT SIGQUIT SIGTSTP

while true; do

	menu
	read_choice

done
