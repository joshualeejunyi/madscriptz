#!/bin/bash

echo "hello! this is to help me bring my servers in and out of the network"
echo "cause i have to keep doing this and i want to cry already!"

echo "do you want to go to VMNet (1) or bring in to Internet Zone (2)?"

read option

echo "you have selected" $option

if [ $option -eq 1 ]
then
	echo "changing to dhcp"
	sudo cp ./template/vmnet /etc/network/interfaces
	echo "changed to dhcp"
	echo "removing proxy"
	sudo cp ./template/noproxy /etc/environment
	echo "proxy removed"
	echo "removing proxy for apt"
	sudo rm /etc/apt/apt.conf.d/95proxies
	echo "removed proxy for apt"
	echo "done"
	echo "network changed. restarting network"
	init 6

elif [ $option -eq 2 ]
then
	echo "changing to internet zone"
	cp ./template/internet ./internet
	read -p "what is your ip address >>>"
	sed -i "s/\${i}/$REPLY/" internet
	read -p "what is your netmask >>>"
	sed -i "s/\${j}/$REPLY/" internet
	read -p "what is your network >>>"
	sed -i "s/\${k}/$REPLY/" internet
	read -p "what is your gateway >>>"
	sed -i "s/\${l}/$REPLY/" internet
	read -p "what is your dns >>>"
	sed -i "s/\${m}/$REPLY/" internet
	sudo cp ./internet /etc/network/interfaces
	echo "changed to internet ip"


	cp ./template/proxy ./proxy
	cp ./template/95proxies ./95proxies

	read -p "what is your proxy >>>"
	sed -i "s/\${o}/$REPLY/" proxy
	sed -i "s/\${o}/$REPLY/" 95proxies

	echo "adding proxy (if that even helps in the first place)"
	sudo cp ./proxy /etc/environment
	echo "proxy added"
	echo "adding proxy for apt"
	sudo cp ./95proxies /etc/apt/apt.conf.d/95proxies
	echo "done"
	echo "cleaning up"
	sudo rm 95proxies
	sudo rm proxy
	sudo rm internet
	echo "network changed. restarting network"
	init 6
	
else
	echo "invalid option. bye"
fi
