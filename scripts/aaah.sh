#!/bin/bash

echo "hello! this is to help me bring my servers in and out of the network"
echo "cause i have to keep doing this and i want to cry already!"

echo "do you want to go to VMNet (1) or bring in to Internet Zone (2)?"

read option

echo "you have selected" $option

if [ $option -eq 1 ]
then
	echo "changing to dhcp"
	sudo cp ./vmnet /etc/network/interfaces
	echo "changed to dhcp"
	echo "removing proxy"
	sudo cp ./noproxy /etc/environment
	echo "proxy removed"
	echo "removing proxy for apt"
	sudo rm /etc/apt/apt.conf.d/95proxies
	echo "removed proxy for apt"
	echo "done"
	echo "network changed. restarting in 5 seconds"
	sleep 5
	init 6

elif [ $option -eq 2 ]
then
	echo "changing to internet zone"
	sudo cp ./internet /etc/network/interfaces
	echo "changed to internet ip"
	echo "adding proxy (if that even helps in the first place)"
	sudo cp ./proxy /etc/environment
	echo "proxy added"
	echo "adding proxy for apt"
	sudo cp ./95proxies /etc/apt/apt.conf.d/95proxies
	echo "done"
	echo "network changed. restarting in 5 seconds"
	sleep 5
	init 6
else
	echo "invalid option. bye"
fi
