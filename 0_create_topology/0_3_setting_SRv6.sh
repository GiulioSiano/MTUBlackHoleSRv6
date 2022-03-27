#!/usr/bin/sudo bash

#Setting SRv6 up

#Setting BSID
#E1
sudo vppctl -s /run/vpp/cli-vppE1.sock create loopback interface instance 0 >/dev/null &
wait "$!"
sudo vppctl -s /run/vpp/cli-vppE1.sock set interface state loop0 up
sudo vppctl -s /run/vpp/cli-vppE1.sock set interface ip address loop0 e1::/128
#E2
sudo vppctl -s /run/vpp/cli-vppE2.sock create loopback interface instance 0 >/dev/null &
wait "$!"
sudo vppctl -s /run/vpp/cli-vppE2.sock set interface state loop0 up
sudo vppctl -s /run/vpp/cli-vppE2.sock set interface ip address loop0 e2::/128

#BSID ROUTING TABLE
sudo vppctl -s /run/vpp/cli-vppE1.sock ip route add c1::/128 via fc00::1:0:2
sudo vppctl -s /run/vpp/cli-vppE1.sock ip route add c3::/128 via fc00::6:0:2

sudo vppctl -s /run/vpp/cli-vppC1.sock ip route add e1::9/128 via fc00::1:0:1
sudo vppctl -s /run/vpp/cli-vppC1.sock ip route add c3::/128 via fc00::7:0:2
sudo vppctl -s /run/vpp/cli-vppC1.sock ip route add c2::/128 via fc00::2:0:2

sudo vppctl -s /run/vpp/cli-vppC2.sock ip route add c1::/128 via fc00::2:0:1
sudo vppctl -s /run/vpp/cli-vppC2.sock ip route add c4::/128 via fc00::8:0:2
sudo vppctl -s /run/vpp/cli-vppC2.sock ip route add e2::9/128 via fc00::3:0:2

sudo vppctl -s /run/vpp/cli-vppC3.sock ip route add c1::/128 via fc00::7:0:1
sudo vppctl -s /run/vpp/cli-vppC3.sock ip route add c4::/128 via fc00::5:0:1
sudo vppctl -s /run/vpp/cli-vppC3.sock ip route add e1::9/128 via fc00::6:0:1

sudo vppctl -s /run/vpp/cli-vppC4.sock ip route add c3::/128 via fc00::5:0:2
sudo vppctl -s /run/vpp/cli-vppC4.sock ip route add c2::/128 via fc00::8:0:1
sudo vppctl -s /run/vpp/cli-vppC4.sock ip route add e2::9/128 via fc00::4:0:2

sudo vppctl -s /run/vpp/cli-vppE2.sock ip route add c2::/128 via fc00::3:0:1
sudo vppctl -s /run/vpp/cli-vppE2.sock ip route add c4::/128 via fc00::4:0:1

#configuring srv6 
sudo vppctl -s /run/vpp/cli-vppE1.sock set sr encaps source addr e1::
sudo vppctl -s /run/vpp/cli-vppE1.sock sr policy add bsid a1:: next c1:: next c2:: next e2::9 encap
sudo vppctl -s /run/vpp/cli-vppE1.sock sr policy add bsid a3:: next c3:: next c4:: next e2::9 encap
sudo vppctl -s /run/vpp/cli-vppE1.sock sr steer l3 fc00::2:2/112 via bsid a3::
sudo vppctl -s /run/vpp/cli-vppE1.sock sr localsid address e1::9 behavior end.dx6 host-pc1 fc00::1:2

sudo vppctl -s /run/vpp/cli-vppE2.sock set sr encaps source addr e2::
sudo vppctl -s /run/vpp/cli-vppE2.sock sr policy add bsid a1:: next c2:: next c1:: next e1::9 encap
sudo vppctl -s /run/vpp/cli-vppE2.sock sr policy add bsid a3:: next c4:: next c3:: next e1::9 encap
sudo vppctl -s /run/vpp/cli-vppE2.sock sr steer l3 fc00::1:2/112 via bsid a3::
sudo vppctl -s /run/vpp/cli-vppE2.sock sr localsid address e2::9 behavior end.dx6 host-pc2 fc00::2:2

sudo vppctl -s /run/vpp/cli-vppC1.sock sr localsid address c1:: behavior end
sudo vppctl -s /run/vpp/cli-vppC2.sock sr localsid address c2:: behavior end
sudo vppctl -s /run/vpp/cli-vppC3.sock sr localsid address c3:: behavior end
sudo vppctl -s /run/vpp/cli-vppC4.sock sr localsid address c4:: behavior end

sudo python3 moving_node_graph.py

#Because kernel linux has problems with TCP-SRv6 in a fully emulated environment:
ip netns exec ns1 ethtool -K vethns1 tx off >/dev/null 2>&1
ip netns exec ns2 ethtool -K vethns2 tx off >/dev/null 2>&1

#Enabling the top-policy for TCP flows (setting the classifier up)
sudo vppctl -s /run/vpp/cli-vppE1.sock classify table del table 0
sudo vppctl -s /run/vpp/cli-vppE2.sock classify table del table 0

sudo vppctl -s /run/vpp/cli-vppE1.sock classify table mask l3 ip6 src dst proto
sudo vppctl -s /run/vpp/cli-vppE1.sock classify session acl-hit-next 1 table-index 0 match l3 ip6 src fc00::1:2 dst fc00::2:2 proto 6 action set-sr-policy-index 0
sudo vppctl -s /run/vpp/cli-vppE1.sock set interface input acl intfc host-pc1 ip6-table 0

sudo vppctl -s /run/vpp/cli-vppE2.sock classify table mask l3 ip6 src dst proto
sudo vppctl -s /run/vpp/cli-vppE2.sock classify session acl-hit-next 1 table-index 0 match l3 ip6 src fc00::2:2 dst fc00::1:2 proto 6 action set-sr-policy-index 0
sudo vppctl -s /run/vpp/cli-vppE2.sock set interface input acl intfc host-pc2 ip6-table 0
