#! /bin/bash
#Author: Imagine Virt, OATS
#Title: WCTA Cyberpatriot Script, Linux

if [[ $EUID -ne 0 ]]
then
  echo "You must be root to run this script."
  exit 1
fi

#Ubuntu 14.04
oldbuntu() {
 echo "Entering Ubuntu 14.04"
   cd ..
   cd CyPatriot/Linux/Ubuntu\ 14.04
}

#Ubuntu 16.10

#Debian

main() {
echo "
           _
|‾‾|      |_|                             \‾\      /‾/
|  |       _   |‾\ |‾| |‾|  |‾| \‾\  /‾/   \ \    / /
|  |      | |  |  \| | | |  | |  \ \/ /     \ \  / /
|  |____  | |  | \   | | |__| |  / /\ \      \ \/ /  _
|_______| |_|  |_|\__| |______| /_/  \_\      \__/  /_/       "

echo ""
echo "------------------"
echo "What flavor of linux are you running?"
echo "------------------"
echo "1) Ubuntu 14.04"      # Completed
echo "2) Ubuntu 16.10"      # Incomplete
echo "3) Debian"            # Incomplete 
echo "4) Exit"              
}

choose() {
	read -p "Enter choice 1-9: "
	if  [ $REPLY == "1" ]; then
		oldbuntu;

	elif [ $REPLY == "4" ]; then
		echo "$(date +'%m/%d/%Y %r'): Ending script"
		clear
		exit;

	fi
}

trap '' SIGINT SIGQUIT SIGTSTP

while true; do

	main
	choose

done
