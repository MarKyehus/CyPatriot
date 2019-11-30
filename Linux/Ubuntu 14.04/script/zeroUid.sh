#! /bin/bash

echo "$(date +'%m/%d/%Y %r'): Checking for UID's of 0 (Root Access Accounts)"
	echo "$(date +'%m/%d/%Y %r'): Checking for UID's of 0 (Root Access Accounts)" >> $PWDt/log/mhs.log
	touch $PWDt/log/zerouidusers
	touch $PWDt/log/uidusers

	cut -d: -f1,3 /etc/passwd | egrep ':0$' | cut -d: -f1 | grep -v root > $PWDt/log/zerouidusers

	if [ -s $PWDt/log/zerouidusers ]
	then
		echo "$(date +'%m/%d/%Y %r'): There are Zero UID Users! I'm fixing it now!"
		echo "$(date +'%m/%d/%Y %r'): There are Zero UID Users! I'm fixing it now!" >> $PWDt/log/mhs.log

		while IFS='' read -r line || [[ -n "$line" ]]; do
			thing=1
			while true; do
				rand=$(( ( RANDOM % 999 ) + 1000))
				cut -d: -f1,3 /etc/passwd | egrep ":$rand$" | cut -d: -f1 > $PWDt/log/uidusers
				if [ -s $PWDt/log/uidusers ]
				then
					echo "Couldn't find unused UID. Trying Again... $(date +'%m/%d/%Y %r')"
					echo "Couldn't find unused UID. Trying Again... $(date +'%m/%d/%Y %r')" >> $PWDt/log/mhs.log
				else
					break
				fi
			done
			usermod -u $rand -g $rand -o $line
			touch /tmp/oldstring
			old=$(grep "$line" /etc/passwd)
			echo $old > /tmp/oldstring
			sed -i "s~0:0~$rand:$rand~" /tmp/oldstring
			new=$(cat /tmp/oldstring)
			sed -i "s~$old~$new~" /etc/passwd
			echo "ZeroUID User: $line"
			echo "Assigned UID: $rand"
		done < "$PWDt/log/zerouidusers"
		update-passwd
		cut -d: -f1,3 /etc/passwd | egrep ':0$' | cut -d: -f1 | grep -v root > $PWDt/log/zerouidusers

		if [ -s $PWDt/log/zerouidusers ]
		then
			echo "$(date +'%m/%d/%Y %r'): WARNING: UID CHANGE UNSUCCESSFUL!"
			echo "$(date +'%m/%d/%Y %r'): WARNING: UID CHANGE UNSUCCESSFUL!" >> $PWDt/log/mhs.log
		else
			echo "$(date +'%m/%d/%Y %r'): Successfully Changed Zero UIDs!"
			echo "$(date +'%m/%d/%Y %r'): Successfully Changed Zero UIDs!" >> $PWDt/log/mhs.log
		fi
	else
		echo "$(date +'%m/%d/%Y %r'): No Zero UID Users"
		echo "$(date +'%m/%d/%Y %r'): No Zero UID Users" >> $PWDt/log/mhs.log
	fi

