#! /bin/bash

# MySQL
echo -n "MySQL [Y/n] "
read option
if [[ $option =~ ^[Yy]$ ]]
then
  sudo apt-get -y install mysql-server
  # Disable remote access
  sudo sed -i '/bind-address/ c\bind-address = 127.0.0.1' /etc/mysql/my.cnf
  sudo service mysql restart
else
  sudo apt-get -y purge mysql*
fi

# OpenSSH Server
echo -n "OpenSSH Server [Y/n] "
read option
if [[ $option =~ ^[Yy]$ ]]
then
  sudo apt-get -y install openssh-server
  # Disable root login
  sudo sed -i '/^PermitRootLogin/ c\PermitRootLogin no' /etc/ssh/sshd_config
  sudo service ssh restart
else
  sudo apt-get -y purge openssh-server*
fi

# VSFTPD
echo -n "VSFTP [Y/n] "
read option
if [[ $option =~ ^[Yy]$ ]]
then
  sudo apt-get -y install vsftpd
  # Disable anonymous uploads
  sudo sed -i '/^anon_upload_enable/ c\anon_upload_enable no' /etc/vsftpd.conf
  sudo sed -i '/^anonymous_enable/ c\anonymous_enable=NO' /etc/vsftpd.conf
  # FTP user directories use chroot
  sudo sed -i '/^chroot_local_user/ c\chroot_local_user=YES' /etc/vsftpd.conf
  sudo service vsftpd restart
else
  sudo apt-get -y purge vsftpd*
fi

# AntiVirus
echo -n "AntiVirus [Y/n] "
read option
if [[ $option =~ ^[Yy]$ ]]
then
  sudo apt-get install chkrootkit rkhunter lynis clamav
  #chrootkit 
    echo "starting chkrootkit scan"
      chkrootkit -q
	  cont
    
  #rkhunter
  echo "starting rkhunter scan"
      rkhunter --update
      rkhunter --propupd #Run this once at install
      rkhunter -c --enable all --disable none
	  cont
  
  #lynis
    echo "starting lynis scan"
      cd /usr/share/lynis/
      /usr/share/lynis/lynis update info
      /usr/share/lynis/lynis audit system
    cont
  
  #clamav
    echo "starting clamav scan"
      systemctl stop clamav-freshclam
      freshclam --stdout
      systemctl start clamav-freshclam
      clamscan -r -i --stdout --exclude-dir="^/sys" /
    cont
else
  sudo apt-get -y purge chkrootkit*
  sudo apt-get -y purge rkhunter*
  sudo apt-get -y purge lynis*
  sudo apt-get -y purge clamav*
fi

