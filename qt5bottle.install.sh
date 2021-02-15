#!/bin/bash
printf "\033[1;33mQT5Bottle \033[1;37mInstaller by Blackheart Dev. Version 1.0m (15.02.2021)\033[0m\n"

printf "\n\033[0;31m1. Make sure \033[1;31msudo rpi-update\033[0;31m has been run before running this installation.\033[0m\n"
printf "\033[0;31m2. Check that \033[1;31mdeb-src\033[0;31m source is uncommented in \033[1;31m/etc/apt/sources.list\033[0;31m file.\033[0m\n"
printf "\033[0;31m3. Also remember to run \033[1;31msudo apt-get update\033[0;31m and \033[1;31msudo apt-get upgrade\033[0;31m before starting.\033[0m\n\n"

CURRENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ $UID != 0 ]]; then
	printf "\n\033[1;31mPlease run this script with sudo!\033[0m\n\n"
	exit 1
fi

DIR="/usr/local/qt5pi/"

echo "This will install QT5Bottle to $DIR..."
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	if test -d "$DIR"; then
		printf "\n\033[0;31mWARNING: Directory $DIR already exists.\033[0m\n\n"
		read -r -p "Replace? [y/N] " response
		if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
		then
			printf "\n\033[0;36mDeleting $DIR "
			sudo rm -rf $DIR
			printf "\033[1;32m[OK]\033[0m\n"
		else
			printf "\n\033[1;31mCanceled!\033[0m\n\n"
			exit 1
		fi
	fi
	printf "\n\033[0;36mDownloading and unpacking bottle to $DIR...\033[0m\n\n"
    #cd $CURRENTDIR
	sudo wget -c http://www.dropbox.com/s/r1s3vse5snj2r6q/qt5.bottle.rpi.tar -O - | sudo tar -xz -C /usr/local
	#printf "\n\033[1;36mCreating symbolic links...\033[0m\n\n"
	sudo chmod -R 777 /usr/local/qt5pi
	printf "\033[0;36mRebuilding shared libraries links for "
	echo /usr/local/qt5pi/lib | sudo tee /etc/ld.so.conf.d/qt5pi.conf
	cd /usr/local/qt5pi/lib
	sudo ldconfig
	printf "\033[0;36m\nInstalling all dependencies for libqt5gui5...\033[0m\n\n"
	sudo apt-get build-dep libqt5gui5 -y
	printf "\n\033[1;36mAll done!\033[0m\n\n"

else
	printf "\n\033[1;31mCanceled!\033[0m\n\n"
fi
