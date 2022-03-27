#!/usr/bin/sudo bash

sudo pkill vpp
sudo ip netns del ns1 >/dev/null 2>&1	
sudo ip netns del ns2 >/dev/null 2>&1
sudo ip link del E1C1_C1 >/dev/null 2>&1
sudo ip link del C1C2_C2 >/dev/null 2>&1
sudo ip link del C2E2_E2 >/dev/null 2>&1
sudo ip link del E1C3_C3 >/dev/null 2>&1
sudo ip link del C1C3_C3 >/dev/null 2>&1
sudo ip link del C3C4_C4 >/dev/null 2>&1
sudo ip link del C2C4_C4 >/dev/null 2>&1
sudo ip link del C4E2_E2 >/dev/null 2>&1
