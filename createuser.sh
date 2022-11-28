#!/bin/bash

#This script creates a new user on the local system.
#You will be prompted to enter the username (login), the person name and a password.
#The username, password and host for the account will be displayed.


#Make sure the script is being executed with superuser privileges.


if [[ "${UID}" -ne 0 ]]
then
	echo 'Please run with sudo as a root.'
	exit 1
fi

#Get the username (login)

read -p 'Enter the username to create: ' USER_NAME

#Get real name (Contaents for the description field)

read -p 'Enter the name of the person or appliation that will be using this account: ' COMMENT

#Get the pasword.

read  -p 'Enter the password to use for the account: ' PASSWORD

#Create account.

useradd -c "${COMMENT}" -m ${USER_NAME}


#Check to see if userdd command succeeded.
#We don't want to tell user that the account was created when it has't been.

if [[ "${?}" -ne 0 ]]
then 
	echo 'The account could not be created.'
	exit 1
fi

#Set the password

echo ${PASSWORD} | passwd --stdin ${USER_NAME}


if [[ "${?}" -ne 0 ]]
then
	echo 'The password for the account could not be set.'
	exit 1
fi

#Force password change on first login.

passwd -e ${USER_NAME}


# Display the username , password and the host where the user was created.

echo '**********************************************************************************'
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host'
echo "${HOSTNAME}"

exit 0

