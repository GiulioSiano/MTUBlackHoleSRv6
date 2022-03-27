#!/usr/bin/sudo bash

ip netns exec ns1 traceroute -6 -T --mtu fc00::2:2 
sleep 3
echo "The MTU path discovery (TCP) result is:"
ip netns exec ns1 ip route get fc00::2:2


