#!/usr/bin/sudo bash

gnome-terminal -- bash -c "ip netns exec ns2 iperf3 -s -V -p 80; exec bash"
sleep 2
gnome-terminal -- bash -c "ip netns exec ns1 iperf3 -c fc00::2:2 -V -p 80 -k 10 -l 1228; exec bash"
