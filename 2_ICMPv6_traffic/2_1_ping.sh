#!/usr/bin/sudo bash

sudo ip netns exec ns1 ping -c 5 -M do -s 1176 fc00::2:2
