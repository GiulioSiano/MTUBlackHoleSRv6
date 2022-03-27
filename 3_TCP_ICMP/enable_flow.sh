#!/usr/bin/sudo bash

echo 'Start TCP communication: Server on Host B and Client on Host A'
gnome-terminal -- bash -c "ip netns exec ns2 iperf3 -s -V -p 80; exec sudo bash"
sleep 2
gnome-terminal -- bash -c "cd 3_TCP_ICMP/; sh tcp_client.sh; exec sudo bash"

echo 'Ping started'
gnome-terminal -- bash -c "cd 3_TCP_ICMP/; sh 2_1_ping.sh; exec sudo bash"
