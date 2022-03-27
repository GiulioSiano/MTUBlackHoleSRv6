#!/usr/bin/sudo bash

#Creating links among nodes. Setting routes for adjacent nodes.

echo "Instantiating VPP nodes, hosts and links..."

#Link E1C1
ip link add name E1C1_E1 type veth peer name E1C1_C1 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppE1.sock create host-interface name E1C1_E1 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppC1.sock create host-interface name E1C1_C1 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppE1.sock set int state host-E1C1_E1 up
vppctl -s /run/vpp/cli-vppC1.sock set int state host-E1C1_C1 up
vppctl -s /run/vpp/cli-vppE1.sock set int ip address host-E1C1_E1 fc00::1:0:1/112
vppctl -s /run/vpp/cli-vppC1.sock set int ip address host-E1C1_C1 fc00::1:0:2/112

vppctl -s /run/vpp/cli-vppE1.sock set interface mtu 1500 host-E1C1_E1
vppctl -s /run/vpp/cli-vppC1.sock set interface mtu 1500 host-E1C1_C1
#Link C1C2
ip link add name C1C2_C1 type veth peer name C1C2_C2 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppC1.sock create host-interface name C1C2_C1 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppC2.sock create host-interface name C1C2_C2 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppC1.sock set int state host-C1C2_C1 up
vppctl -s /run/vpp/cli-vppC2.sock set int state host-C1C2_C2 up
vppctl -s /run/vpp/cli-vppC1.sock set int ip address host-C1C2_C1 fc00::2:0:1/112
vppctl -s /run/vpp/cli-vppC2.sock set int ip address host-C1C2_C2 fc00::2:0:2/112

vppctl -s /run/vpp/cli-vppC1.sock set interface mtu 1500 host-C1C2_C1
vppctl -s /run/vpp/cli-vppC2.sock set interface mtu 1500 host-C1C2_C2
#Link C2E2
ip link add name C2E2_C2 type veth peer name C2E2_E2 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppC2.sock create host-interface name C2E2_C2 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppE2.sock create host-interface name C2E2_E2 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppC2.sock set int state host-C2E2_C2 up
vppctl -s /run/vpp/cli-vppE2.sock set int state host-C2E2_E2 up
vppctl -s /run/vpp/cli-vppC2.sock set int ip address host-C2E2_C2 fc00::3:0:1/112
vppctl -s /run/vpp/cli-vppE2.sock set int ip address host-C2E2_E2 fc00::3:0:2/112

vppctl -s /run/vpp/cli-vppC2.sock set interface mtu 1500 host-C2E2_C2
vppctl -s /run/vpp/cli-vppE2.sock set interface mtu 1500 host-C2E2_E2
#Link E1C3
ip link add name E1C3_E1 type veth peer name E1C3_C3 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppE1.sock create host-interface name E1C3_E1 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppC3.sock create host-interface name E1C3_C3 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppE1.sock set int state host-E1C3_E1 up
vppctl -s /run/vpp/cli-vppC3.sock set int state host-E1C3_C3 up
vppctl -s /run/vpp/cli-vppE1.sock set int ip address host-E1C3_E1 fc00::6:0:1/112
vppctl -s /run/vpp/cli-vppC3.sock set int ip address host-E1C3_C3 fc00::6:0:2/112

vppctl -s /run/vpp/cli-vppE1.sock set interface mtu 1500 host-E1C3_E1
vppctl -s /run/vpp/cli-vppC3.sock set interface mtu 1500 host-E1C3_C3
#Link C1C3
ip link add name C1C3_C1 type veth peer name C1C3_C3 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppC1.sock create host-interface name C1C3_C1 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppC3.sock create host-interface name C1C3_C3 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppC1.sock set int state host-C1C3_C1 up
vppctl -s /run/vpp/cli-vppC3.sock set int state host-C1C3_C3 up
vppctl -s /run/vpp/cli-vppC1.sock set int ip address host-C1C3_C1 fc00::7:0:1/112
vppctl -s /run/vpp/cli-vppC3.sock set int ip address host-C1C3_C3 fc00::7:0:2/112

vppctl -s /run/vpp/cli-vppC1.sock set interface mtu 1500 host-C1C3_C1
vppctl -s /run/vpp/cli-vppC3.sock set interface mtu 1500 host-C1C3_C3
#Link C3C4
ip link add name C3C4_C3 type veth peer name C3C4_C4 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppC3.sock create host-interface name C3C4_C3 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppC4.sock create host-interface name C3C4_C4 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppC3.sock set int state host-C3C4_C3 up
vppctl -s /run/vpp/cli-vppC4.sock set int state host-C3C4_C4 up
vppctl -s /run/vpp/cli-vppC3.sock set int ip address host-C3C4_C3 fc00::5:0:2/112
vppctl -s /run/vpp/cli-vppC4.sock set int ip address host-C3C4_C4 fc00::5:0:1/112

vppctl -s /run/vpp/cli-vppC3.sock set interface mtu 1400 host-C3C4_C3
vppctl -s /run/vpp/cli-vppC4.sock set interface mtu 1400 host-C3C4_C4
#Link C2C4
ip link add name C2C4_C2 type veth peer name C2C4_C4 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppC2.sock create host-interface name C2C4_C2 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppC4.sock create host-interface name C2C4_C4 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppC2.sock set int state host-C2C4_C2 up
vppctl -s /run/vpp/cli-vppC4.sock set int state host-C2C4_C4 up
vppctl -s /run/vpp/cli-vppC2.sock set int ip address host-C2C4_C2 fc00::8:0:1/112
vppctl -s /run/vpp/cli-vppC4.sock set int ip address host-C2C4_C4 fc00::8:0:2/112

vppctl -s /run/vpp/cli-vppC2.sock set interface mtu 1500 host-C2C4_C2
vppctl -s /run/vpp/cli-vppC4.sock set interface mtu 1500 host-C2C4_C4
#Link C4E2
ip link add name C4E2_C4 type veth peer name C4E2_E2 >/dev/null 2>&1
vppctl -s /run/vpp/cli-vppC4.sock create host-interface name C4E2_C4 >/dev/null &
wait "$!"
vppctl -s /run/vpp/cli-vppE2.sock create host-interface name C4E2_E2 >/dev/null &
wait "$!"

vppctl -s /run/vpp/cli-vppC4.sock set int state host-C4E2_C4 up
vppctl -s /run/vpp/cli-vppE2.sock set int state host-C4E2_E2 up
vppctl -s /run/vpp/cli-vppC4.sock set int ip address host-C4E2_C4 fc00::4:0:1/112
vppctl -s /run/vpp/cli-vppE2.sock set int ip address host-C4E2_E2 fc00::4:0:2/112

vppctl -s /run/vpp/cli-vppC4.sock set interface mtu 1500 host-C4E2_C4
vppctl -s /run/vpp/cli-vppE2.sock set interface mtu 1500 host-C4E2_E2

#Routing Table
#Link E1C1
vppctl -s /run/vpp/cli-vppE1.sock ip route add fc00::1:0:2/112 via fc00::1:0:1
vppctl -s /run/vpp/cli-vppC1.sock ip route add fc00::1:0:1/112 via fc00::1:0:2
vppctl -s /run/vpp/cli-vppC1.sock ip route add fc00::1:2/112 via fc00::1:0:1
#Link C1C2
vppctl -s /run/vpp/cli-vppC1.sock ip route add fc00::2:0:2/112 via fc00::2:0:1
vppctl -s /run/vpp/cli-vppC2.sock ip route add fc00::2:0:1/112 via fc00::2:0:2
#Link C2E2
vppctl -s /run/vpp/cli-vppC2.sock ip route add fc00::3:0:2/112 via fc00::3:0:1
vppctl -s /run/vpp/cli-vppE2.sock ip route add fc00::3:0:1/112 via fc00::3:0:2
vppctl -s /run/vpp/cli-vppC2.sock ip route add fc00::2:2/112 via fc00::3:0:2
#Link E1C3
vppctl -s /run/vpp/cli-vppE1.sock ip route add fc00::6:0:2/112 via fc00::6:0:1
vppctl -s /run/vpp/cli-vppC3.sock ip route add fc00::6:0:1/112 via fc00::6:0:2
#Link C1C3
vppctl -s /run/vpp/cli-vppC1.sock ip route add fc00::7:0:2/112 via fc00::7:0:1
vppctl -s /run/vpp/cli-vppC3.sock ip route add fc00::7:0:1/112 via fc00::7:0:2
#Link C3C4
vppctl -s /run/vpp/cli-vppC3.sock ip route add fc00::5:0:1/112 via fc00::5:0:2
vppctl -s /run/vpp/cli-vppC4.sock ip route add fc00::5:0:2/112 via fc00::5:0:1
#Link C2C4
vppctl -s /run/vpp/cli-vppC2.sock ip route add fc00::8:0:2/112 via fc00::8:0:1
vppctl -s /run/vpp/cli-vppC4.sock ip route add fc00::8:0:1/112 via fc00::8:0:2
#Link C4E2
vppctl -s /run/vpp/cli-vppC4.sock ip route add fc00::4:0:2/112 via fc00::4:0:1
vppctl -s /run/vpp/cli-vppE2.sock ip route add fc00::4:0:1/112 via fc00::4:0:2

