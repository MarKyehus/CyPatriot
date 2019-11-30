#! /bin/bash
if [[ $EUID -ne 0 ]]
then
  echo "You must be root to run this script."
  exit 1
fi

# Lock Out Root User
sudo passwd -l root

# Configure Password Aging Controls
sudo sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS   90' /etc/login.defs
sudo sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS   10'  /etc/login.defs
sudo sed -i '/^PASS_WARN_AGE/ c\PASS_WARN_AGE   7' /etc/login.defs

# Password Authentication
sudo sed -i '1 s/^/auth optional pam_tally.so deny=5 unlock_time=900 onerr=fail audit even_deny_root_account silent\n/' /etc/pam.d/common-auth

# Force Strong Passwords
sudo apt-get -y install libpam-cracklib
sudo sed -i '1 s/^/password requisite pam_cracklib.so retry=3 minlen=8 difok=3 reject_username minclass=3 maxrepeat=2 dcredit=1 ucredit=1 lcredit=1 ocredit=1\n/' /etc/pam.d/common-password



