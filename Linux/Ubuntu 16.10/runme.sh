#! /bin/bash
#Author: Imagine Virt [12-3253], OATS 
#Title: WCTA Cyberpatriot Script, Linux 

## Functions ##

#Updates 
aptf() {
 echo "Updating System"
 echo "$(date +'%m/%d/%Y %r'): Updating System" >> ./log/oats.txt
    sudo chattr -i /etc/apt/sources.list
    sudo chmod 777 /etc/apt/sources.list
    sudo apt-get upgrade
    sudo apt-get update
 echo "$(date +'%m/%d/%Y %r'): Updated System" >> ./log/oats.txt
   stop
}

#Remove 
erase() {
 echo "Removing Apps, Media, and Services"
 echo "$(date +'%m/%d/%Y %r'): Removing Apps, Media, and Services" >> ./log/oats.txt
   chmod +x ./script/purge.sh 
   sudo ./script/purge.sh 
 echo "$(date +'%m/%d/%Y %r'): Removed Apps, Media, and Services" >> ./log/oats.txt
  stop
}

#Firewall
fire() {
 echo "Hardening the firewall"
 echo "$(date +'%m/%d/%Y %r'): Updating Firewall" >> ./log/oats.txt
   chmod +x ./script/firewall.sh
   sudo ./script/firewall.sh
 echo "$(date +'%m/%d/%Y %r'): Updated Firewall" >> ./log/oats.txt
  stop
}

#Firewall Extra 
firecont() {
 echo "$(date +'%m/%d/%Y %r'): Updating Firewall" >> ./log/oats.txt
   chmod +x ./script/firecont.sh
   sudo ./script/firecont.sh
 echo "$(date +'%m/%d/%Y %r'): Updated Firewall" >> ./log/oats.txt
  stop
} 

#Passwd Policies
passif() {
 echo "Updating Password Policies"
 echo "$(date +'%m/%d/%Y %r'): Updating Password Policies" >> ./log/oats.txt
   chmod +x ./script/pass.sh
   sudo ./script/pass.sh
 echo "$(date +'%m/%d/%Y %r'): Updated Password Policies" >> ./log/oats.txt
  stop
}

#UID root check
zeroUid() {
 echo "Checking for 0Uid"
 echo "$(date +'%m/%d/%Y %r'): Checking for Root Users" >> ./log/oats.txt
  chmod +x ./script/pass.sh
  sudo ./script/zeroUid.sh
 echo "$(date +'%m/%d/%Y %r'): Checked for Root Users" >> ./log/oats.txt
 stop
}

#Account Policy
accountif() {
 echo "Changing User Account Policies"
 echo "$(date +'%m/%d/%Y %r'): Changing User Account Policies" >> ./log/oats.txt
   chmod +x ./script/account.sh
   sudo ./script/account.sh
 echo "$(date +'%m/%d/%Y %r'): Changed User Account Policies" >> ./log/oats.txt
  stop
}

#Installation
aptint() {
 echo "Intalling Software"
 echo "$(date +'%m/%d/%Y %r'): Intalling Software" >> ./log/oats.txt
   chmod +x ./script/install.sh
   sudo ./script/install.sh
 echo "$(date +'%m/%d/%Y %r'): Intalling Software" >> ./log/oats.txt
  stop
} 

#Pause before each sub-script
stop() {
	echo "Continue? (Y/N) "
	read continu
	if [ "$continu" = "N" ] || [ "$continu" = "n" ]; then
		echo "$(date +'%m/%d/%Y %r'): Ending script"
		echo "$(date +'%m/%d/%Y %r'): Ending script" >> ./log/oats.txt
		exit;
	fi
}

#Menu of Ubuntu 16.10 
menu() {
	clear
	echo "$(date +'%m/%d/%Y %r'): Starting Script" >> ./log/oats.txt
	echo "
    ____                   ____        _      __ 
   / __ \___  ___ ___     / __/_______(_)__  / /_
  / /_/ / _ \/ -_) _ \   _\ \/ __/ __/ / _ \/ __/
  \____/ .__/\__/_//_/  /___/\__/_/ /_/ .__/\__/ 
      /_/                            /_/         
"
	echo "------------------"
	echo " M A I N _ M E N U"
	echo "------------------"
	echo "1) Updates System"				#aptf
	echo "2) Purges Media, Services, Apps"			#erase
	echo "3) Update the Firewall"				#fire
	echo "4) Stronger Firewall"				#firecont
	echo "5) Update Passwd Policies users"			#passif
	echo "6) Check for UID's of 0 (Root Access Acounts)"	#zeroUid
	echo "7) User Account Policies" 			#accountif
	echo "8) Intall Software" 				#aptint
	echo "9) Auto Run" 					#runs all programs besides usersif and firecont
	echo "10) Open Log"
	echo "11) Exit"
}

#Menu Selections
read_choice() {
	read -p "Enter choice 1-12: "
	if  [ $REPLY == "1" ]; then
		aptf;

	elif [ $REPLY == "2" ]; then
		erase;
	
	elif [ $REPLY == "3" ]; then
		fire;
		
	elif [ $REPLY == "4" ]; then
		firecont;

	elif [ $REPLY == "5" ]; then
		passif;

	elif [ $REPLY == "6" ]; then
		zeroUid;
		
	elif [ $REPLY == "7" ]; then
		usersif;
		
	elif [ $REPLY == "8" ]; then
		aptint;
		
	elif [ $REPLY == "9" ]; then
		aptf;
		erase;
		fire;
		passif;
		zeroUid;
		accountif;
		aptint;

	elif [ $REPLY == "10" ]; then
		gedit ./log/oats.txt

	elif [ $REPLY == "11" ]; then
		echo "$(date +'%m/%d/%Y %r'): Ending script"
		echo "$(date +'%m/%d/%Y %r'): Ending script" >> ./log/oats.txt
		exit;

	fi
}

trap '' SIGINT SIGQUIT SIGTSTP

while true; do

	menu
	read_choice

done
