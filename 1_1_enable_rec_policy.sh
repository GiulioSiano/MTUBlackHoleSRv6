#!/usr/bin/sudo bash

#Enabling Recovery Policy

sudo vppctl -s /run/vpp/cli-vppC1.sock ip route del c2::/128 via fc00::2:0:2
sudo vppctl -s /run/vpp/cli-vppC1.sock sr policy add bsid a2:: next c3:: next c4::1 encap
sudo vppctl -s /run/vpp/cli-vppC1.sock sr steer l3 c2::/128 via bsid a2::

sudo vppctl -s /run/vpp/cli-vppC4.sock ip route add c3::1/128 via fc00::5:0:2
sudo vppctl -s /run/vpp/cli-vppC4.sock sr localsid address c4::1 behavior end.dx6 host-C2C4_C4 fc00::8:0:1
sudo vppctl -s /run/vpp/cli-vppC4.sock ip route del fc00::8:0:1/112 via fc00::8:0:2

sudo vppctl -s /run/vpp/cli-vppC2.sock ip route del c1::/128 via fc00::2:0:1
sudo vppctl -s /run/vpp/cli-vppC2.sock sr policy add bsid a2:: next c4:: next c3::1 encap
sudo vppctl -s /run/vpp/cli-vppC2.sock sr steer l3 c1::/128 via bsid a2::

sudo vppctl -s /run/vpp/cli-vppC3.sock ip route add c4::1/128 via fc00::5:0:1
sudo vppctl -s /run/vpp/cli-vppC3.sock sr localsid address c3::1 behavior end.dx6 host-C1C3_C3 fc00::7:0:1
sudo vppctl -s /run/vpp/cli-vppC3.sock ip route del fc00::7:0:1/112 via fc00::7:0:2
