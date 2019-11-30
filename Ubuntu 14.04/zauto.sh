#! /bin/bash
#Author: Imagine Virt [12-3253], OATS 
#Title: WCTA Cyberpatriot Script, Linux 

#Variables
PWDt=$(pwd)

#Startup
echo "$(date +'%m/%d/%Y %r'): Verifying an internet connection with aptitude"
echo "$(date +'%m/%d/%Y %r'): Verifying an internet connection with aptitude" >> $PWDt/log/mhs.log
apt-get install cowsay -y &> /dev/null
if [ "$?" -eq "1" ]; then
   echo "$(date +'%m/%d/%Y %r'): This script cannot access aptitude properly."
   echo "$(date +'%m/%d/%Y %r'): Apititude check failed" >> $PWDt/log/mhs.log
   exit 1
fi
unalias -a
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
echo "$(date +'%m/%d/%Y %r'): Starting script" >> $PWDt/log/mhs.log

if ! [ -d $PWDt/config ]; then
	echo "$(date +'%m/%d/%Y %r'): Please Cd into cyberpat directory and run the script there."
	echo "$(date +'%m/%d/%Y %r'): Please Cd into cyberpat directory and run the script there." >> $PWDt/log/mhs.log
	exit
fi

if [ "$EUID" -ne 0 ]; then
	echo "$(date +'%m/%d/%Y %r'): Run as Root" 
	echo "$(date +'%m/%d/%Y %r'): Run as Root" >> $PWDt/log/mhs.log
	exit
fi

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
	echo "1) Updates System"
	echo "2) Purges Media, Services, Apps"
	echo "3) Updates the Firewall"
	echo "4) Updates Passwd Policies users"
	echo "5) Check for UID's of 0 (Root Access Acounts)"
	echo "6) Add, Remove, or Promotes User Accounts"
	echo "7) More User restrictions"
	echo "8) Go to Logs"
	echo "9) Exit"
}

stop() {
	echo "Continue? (Y/N) "
	read continu
	if [ "$continu" = "N" ] || [ "$continu" = "n" ]; then
		echo "$(date +'%m/%d/%Y %r'): Ending script"
		echo "$(date +'%m/%d/%Y %r'): Ending script" >> $PWDt/log/mhs.log
		exit;
	fi
}

#Updates 
aptf() {
 echo "Updating"
    sudo apt-get upgrade
    sudo apt-get update
   stop
}

#Remove 
erase() {
 echo "Removing Apps, Media, and Services"
   sudo ./script/purge.sh 
  stop
}

#Firewall
fire() {
 echo "Hardening the firewall"
   sudo ./script/firewall.sh
  stop
}

#Passwd Policies
pass() {
 echo "Updating Password Policies"
   sudo ./script/firewall.sh
  stop
}

#UID root check
zeroUid() {
 echo"Checking for 0Uid"
  sudo ./script/zeroUid.sh
 stop
}
#Users Accounts
usersif() {
 echo "Adds, Removes, or Promotes User Accounts"
 echo "Copy the README users into the txt file"
  sudo ./script/users.sh
 stop
}

#Account Policy
accountif() {
 echo "Changing User Account Policies"
   sudo ./script/account.sh
  stop
}



#### Fine tuning network parameters for better perfomance
# Change the following parameters when a high rate of incoming connection requests result in connection failures
echo "100000" > /proc/sys/net/core/netdev_max_backlog
# Size of the listen queue for accepting new TCP connections (default: 128)
echo "4096" > /proc/sys/net/core/somaxconn
# Maximum number of sockets in TIME-WAIT to be held simultaneously (default: 180000)
echo "600000" > /proc/sys/net/ipv4/tcp_max_tw_buckets
# sets the Maximum Socket Receive Buffer for all protocols (in bytes)
echo "16777216" > /proc/sys/net/core/rmem_max
echo "16777216" > /proc/sys/net/core/rmem_default
# sets the Maximum Socket Send Buffer for all protocols (in bytes)
echo "16777216" > /proc/sys/net/core/wmem_max
echo "16777216" > /proc/sys/net/core/wmem_default
# Set Linux autotuning TCP buffer limits
echo "4096 87380 16777216" > /proc/sys/net/ipv4/tcp_rmem
echo "4096 87380 16777216" > /proc/sys/net/ipv4/tcp_wmem

echo "0" > /proc/sys/net/ipv4/tcp_sack
echo "0" > /proc/sys/net/ipv4/tcp_dsack
# By default, TCP saves various connection metrics in the route cache when the connection closes, so that connections established in the near future can use these to set initial conditions. Usually, this increases overall performance, but may sometimes cause performance degradation. If set, TCP will not cache metrics on closing connections.
echo "1" > /proc/sys/net/ipv4/tcp_no_metrics_save
# How many times to retry before killing an alive TCP connection
echo "5" > /proc/sys/net/ipv4/tcp_retries2
# How often to send TCP keepalive packets to keep an connection alive if it is currently unused. This value is only used when keepalive is enabled
echo "120" > /proc/sys/net/ipv4/tcp_keepalive_time
# How long to wait for a reply on each keepalive probe. This value is in other words extremely important when you try to calculate how long time will go before your connection will die a keepalive death. 
echo "30" > /proc/sys/net/ipv4/tcp_keepalive_intvl
# Determines the number of probes before timing out
echo "3" > /proc/sys/net/ipv4/tcp_keepalive_probes
# How long to keep sockets in the state FIN-WAIT-2 if you were the one closing the socket (default: 60)
echo "30" > /proc/sys/net/ipv4/tcp_fin_timeout
# Sometimes, packet reordering in a network can be interpreted as packet loss and hence increasing the value of this parameter should improve performance (default is “3″)
echo "15" > /proc/sys/net/ipv4/tcp_reordering
#
echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
# This value varies depending on total memory of the system. Use it wisely in different situations
# echo "262144" > /proc/sys/net/ipv4/tcp_max_orphans

# Disable Core Dumps
echo "0" > /proc/sys/fs/suid_dumpable
# Enable ExecShield
echo "1" > /proc/sys/kernel/exec-shield
echo "1" > /proc/sys/kernel/randomize_va_space
#### Network parameters for better security
# Disable packet forwarding (if this machine is not a router)
echo "0" > /proc/sys/net/ipv4/ip_forward
echo "0" > /proc/sys/net/ipv4/conf/all/send_redirects
echo "0" > /proc/sys/net/ipv4/conf/default/send_redirects
# Enable tcp_syncookies to accept legitimate connections when faced with a SYN flood attack
echo "1" > /proc/sys/net/ipv4/tcp_syncookies
# Turn off to disable IPv4 protocol features which are considered to have few legitimate uses and to be easy to abuse
echo "0" > /proc/sys/net/ipv4/conf/all/accept_source_route
echo "0" > /proc/sys/net/ipv4/conf/default/accept_source_route
echo "0" > /proc/sys/net/ipv4/conf/all/accept_redirects
echo "0" > /proc/sys/net/ipv4/conf/default/accept_redirects
echo "0" > /proc/sys/net/ipv4/conf/all/secure_redirects 
echo "0" > /proc/sys/net/ipv4/conf/default/secure_redirects 
# Log suspicious packets (This should be turned off if the system is suffering from too much logging)
echo "1" > /proc/sys/net/ipv4/conf/all/log_martians
# Protect from ICMP attacks 
echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
# Enable RFC-recommended source validation (should not be used on machines which are routers for very complicated networks)
echo "1" > /proc/sys/net/ipv4/conf/all/rp_filter
echo "1" > /proc/sys/net/ipv4/conf/default/rp_filter
# Increase IPv4 port range to accept more connections
echo "5000 65535" > /proc/sys/net/ipv4/ip_local_port_range

# Disable IPV6
echo "1" > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo "1" > /proc/sys/net/ipv6/conf/default/disable_ipv6
# 
#### File system tuning 
# Increase system file descriptor limit
echo "7930900" > /proc/sys/fs/file-max
# Allow for more PIDs
echo "65536" > /proc/sys/kernel/pid_max
# Use up to 95% of RAM (5% free)
echo "5" > /proc/sys/vm/swappiness
#
echo "20" > /proc/sys/vm/dirty_background_ratio
#
echo "25" > /proc/sys/vm/dirty_ratio


