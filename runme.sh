if [[ $EUID -ne 0 ]]
then
  echo "You must be root to run this script."
  exit 1
fi

#Ubuntu 14.04
oldbuntu() {
 echo "Entering Ubuntu 14.04"
  echo "$(date +'%m/%d/%Y %r'): Selected Ubuntu 14.04" >> $PWDt/log/logger.log
   sudo ./Ubuntu 14.04/zauto.sh
  stop
}

#Ubuntu 16.10

#Debian

mainmenu() {
	clear
	echo "
           _
|‾‾|      |_|                             \‾\      /‾/
|  |       _   |‾\ |‾| |‾|  |‾| \‾\  /‾/   \ \    / /
|  |      | |  |  \| | | |  | |  \ \/ /     \ \  / /
|  |____  | |  | \   | | |__| |  / /\ \      \ \/ /  
|_______| |_|  |_|\__| |______| /_/  \_\      \__/  /‾_/
"
	echo "------------------"
	echo " What flavor of linux are you running"
	echo "------------------"
	echo "1) Ubuntu 14.04"      # Completed
	echo "2) Ubuntu 16.10"      # Incomplete
  echo "3) Debian"            # Incomplete 
  echo "4) Exit"              

}

selchoose() {
	read -p "Enter choice 1-9: "
	if  [ $REPLY == "1" ]; then
		oldbuntu;

 
	elif [ $REPLY == "10"] then
		gedit $PWDt/log/logger.log

	elif [ $REPLY == "11"]; then
		echo "$(date +'%m/%d/%Y %r'): Ending script"
		echo "$(date +'%m/%d/%Y %r'): Ending script" >> $PWDt/log/logger.log
		exit 0;

	fi
}

trap '' SIGINT SIGQUIT SIGTSTP

while true; do

	mainmenu
	selchoose

done
