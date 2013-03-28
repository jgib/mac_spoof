#!/bin/bash
main(){
ls /sys/class/net/;
echo -ne "\nEnter interface to spoof: ";
read interface;
if [ -e /sys/class/net/$interface ]; then
	if [ "$interface" = "lo" ]; then
		clear
		echo -e "Loopback dose not have a MAC address to spoof.\n"
		main
	elif [ "$interface" = "" ]; then
		clear
		echo -e "Interface does not exist.\n"
		main	
	fi
enter.mac
else
        clear
        echo -e "Interface does not exist.\n"
        main
fi
}
enter.mac(){
echo -en "\nEnter new MAC address for $interface: ";
read mac;
sudo ifconfig $interface down;
sudo ifconfig $interface hw ether $mac;
if [ $? -ne 0 ]; then
	clear
	echo -e "\nIncorrect MAC address entered."
	enter.mac
else
	sudo ifconfig $interface up;
	ask;
fi
}
ask(){
echo -en "\nDo you wish to spoof an interface? (y/n) ";
read choice;
case "$choice" in
y)	main
	;;
Y)	main
	;;
yes)	main
	;;
YES)	main
	;;
Yes)	main
	;;
n)	exit 0
	;;
N)	exit 0
	;;
no)	exit 0
	;;
NO)	exit 0
	;;
No)	exit 0
	;;
*)	clear
	echo "Incorrect input."
	ask
	;;
esac
}
clear
ask
