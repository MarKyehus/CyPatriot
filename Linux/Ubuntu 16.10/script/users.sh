#Delete bad users
#For every user in /etc/passwd file who isn’t mentioned in the README, removes them and deletes everything they have
for i in $(cat /etc/passwd | cut -d: -f 1,3,6 | grep -e "[5-9][0-9][0-9]" -e "[0-9][0-9][0-9][0-9]" | grep "/home" | cut -d: -f1) ; do
	if [[ $( grep -ic -e $i $(pwd)/README ) -eq 0 ]]; then	
		(deluser $i --remove-all-files >> RemovingUsers.txt 2>&1) &  #starts deleting in background
	fi
done
echo "Finished with deleting bad users"

#For everyone in the addusers file, creates the user
echo "" >> addusers.txt
for i in $(cat $(pwd)/addusers.txt); do
	useradd $i;
done
echo "Finished adding users"

#Goes and makes users admin/not admin as needed
#for every user with UID above 500 that has a home directory
for i in $(cat /etc/passwd | cut -d: -f 1,3,6 | grep -e "[5-9][0-9][0-9]" -e "[0-9][0-9][0-9][0-9]" | grep "/home" | cut -d: -f1); do
	#If the user is supposed to be a normal user but is in the sudo group, remove them from sudo
	BadUser=0
	if [[ $( grep -ic $i $(pwd)/users.txt ) -ne 0 ]]; then	
		if [[ $( echo $( grep "sudo" /etc/group) | grep -ic $i ) -ne 0 ]]; then	
			#if username is in sudo when shouldn’t
			deluser $i sudo;
			echo "removing $i from sudo" >> usersChanged.txt
		fi
if [[ $( echo $( grep "adm" /etc/group) | grep -ic $i ) -ne 0 ]]; then	
			#if username is in adm when shouldn’t
			deluser $i adm;
			echo "removing $i from adm" >> usersChanged.txt
		fi
	else
		BadUser=$((BadUser+1));
	fi
	#If user is supposed to be an adm but isn’t, raise privilege.
	if [[ $( grep -ic $i $(pwd)/admin.txt ) -ne 0 ]]; then	
		if [[ $( echo $( grep "sudo" /etc/group) | grep -ic $i ) -eq 0 ]]; then	
			#if username isn't in sudo when should
			usermod -a -G "sudo" $i
			echo "add $i to sudo"  >> usersChanged.txt
		fi
if [[ $( echo $( grep "adm" /etc/group) | grep -ic $i ) -eq 0 ]]; then	
			#if username isn't in adm when should
			usermod -a -G "adm" $i
			echo "add $i to adm"  >> usersChanged.txt
		fi
	else
		BadUser=$((BadUser+1));
	fi
	if [[ $BadUser -eq 2 ]]; then
		echo "WARNING: USER $i HAS AN ID THAT IS CONSISTENT WITH A NEWLY ADDED USER YET IS NOT MENTIONED IN EITHER THE admin.txt OR users.txt FILE. LOOK INTO THIS." >> usersChanged.txt
	fi
done
echo "Finished changing users"
