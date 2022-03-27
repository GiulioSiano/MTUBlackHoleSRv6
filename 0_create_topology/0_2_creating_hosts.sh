#!/usr/bin/sudo bash
#Setting hosts up and linking them to routers

#HOSTS
ip netns add ns1
ip link add pc1 type veth peer name vethns1
ip link set vethns1 netns ns1
ip netns exec ns1 ip link set lo up
ip netns exec ns1 ip link set vethns1 up
ip link set pc1 up
ip netns exec ns1 ip route flush table main 	#flush preexistent routing table records
ip netns exec ns1 ip addr flush dev vethns1
ip netns exec ns1 ifconfig vethns1 down
ip netns exec ns1 ifconfig vethns1 hw ether 12:22:33:44:55:66
ip netns exec ns1 ifconfig vethns1 up
ip netns exec ns1 ip addr add fc00::1:2/112 dev vethns1
ip netns exec ns1 ip route add default via fc00::1:1


ip netns add ns2
ip link add pc2 type veth peer name vethns2
ip link set vethns2 netns ns2
ip netns exec ns2 ip link set lo up
ip netns exec ns2 ip link set vethns2 up
ip link set pc2 up
ip netns exec ns2 ip route flush table main 	#flush preexistent routing table records
ip netns exec ns2 ip addr flush dev vethns2
ip netns exec ns2 ifconfig vethns2 down
ip netns exec ns2 ifconfig vethns2 hw ether 66:55:44:33:22:11
ip netns exec ns2 ifconfig vethns2 up
ip netns exec ns2 ip addr add fc00::2:2/112 dev vethns2
ip netns exec ns2 ip route add default via fc00::2:1


#LINK HOSTS TO VPP
sudo vppctl -s /run/vpp/cli-vppE1.sock create host-interface name pc1 >/dev/null &
wait "$!"
sudo vppctl -s /run/vpp/cli-vppE1.sock set interface mtu 1300 host-pc1
sudo vppctl -s /run/vpp/cli-vppE1.sock set interface state host-pc1 up
sudo vppctl -s /run/vpp/cli-vppE1.sock set interface ip address host-pc1 fc00::1:1/112
sudo vppctl -s /run/vpp/cli-vppE1.sock set interface mac address host-pc1 66:55:44:33:77:71

sudo vppctl -s /run/vpp/cli-vppE2.sock create host-interface name pc2 >/dev/null &
wait "$!"
sudo vppctl -s /run/vpp/cli-vppE2.sock set interface mtu 1300 host-pc2
sudo vppctl -s /run/vpp/cli-vppE2.sock set interface state host-pc2 up
sudo vppctl -s /run/vpp/cli-vppE2.sock set interface ip address host-pc2 fc00::2:1/112

#SEND IPv6 Neighbor Discovery Messages
echo "Performing ping to force the exchanging of IPv6 Neighbor Discovery Messages..."
ip netns exec ns1 ping -c 1 fc00::1:0:2 >/dev/null 2>&1
ip netns exec ns2 ping -c 1 fc00::3:0:1 >/dev/null 2>&1
