#!/usr/bin/sudo bash


while true
do
	sudo ip netns exec ns1 ping -M do fc00::2:2
done
