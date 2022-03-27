#!/usr/bin/sudo bash

vppctl -s /run/vpp/cli-vppE1.sock clear trace
vppctl -s /run/vpp/cli-vppC1.sock clear trace
vppctl -s /run/vpp/cli-vppC2.sock clear trace
vppctl -s /run/vpp/cli-vppC3.sock clear trace
vppctl -s /run/vpp/cli-vppC4.sock clear trace
vppctl -s /run/vpp/cli-vppE2.sock clear trace

vppctl -s /run/vpp/cli-vppE1.sock trace add af-packet-input 30
vppctl -s /run/vpp/cli-vppC1.sock trace add af-packet-input 30
vppctl -s /run/vpp/cli-vppC2.sock trace add af-packet-input 30
vppctl -s /run/vpp/cli-vppC3.sock trace add af-packet-input 30
vppctl -s /run/vpp/cli-vppC4.sock trace add af-packet-input 30
vppctl -s /run/vpp/cli-vppE2.sock trace add af-packet-input 30

