#!/usr/bin/sudo bash

while true
do
	ip netns exec ns1 iperf3 -6 -c fc00::2:2 -V -p 80 -k 1 -F 'big_file'
	exec sudo bash
done
