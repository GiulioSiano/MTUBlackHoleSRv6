#!/usr/bin/sudo bash

#Closing VPP instances and deletes links
sh ./9_exit_kill_VPP.sh

#Starting VPP instances
sudo vpp unix {cli-listen /run/vpp/cli-vppE1.sock} api-segment { prefix vppE1 } &
wait "$!"	#wait for last process launched (vppE1 launcher) to finish
sudo vpp unix {cli-listen /run/vpp/cli-vppC1.sock} api-segment { prefix vppC1 } &
wait "$!"
sudo vpp unix {cli-listen /run/vpp/cli-vppC2.sock} api-segment { prefix vppC2 } &
wait "$!"
sudo vpp unix {cli-listen /run/vpp/cli-vppE2.sock} api-segment { prefix vppE2 } &
wait "$!"
sudo vpp unix {cli-listen /run/vpp/cli-vppC3.sock} api-segment { prefix vppC3 } &
wait "$!"
sudo vpp unix {cli-listen /run/vpp/cli-vppC4.sock} api-segment { prefix vppC4 } &
wait "$!"
sleep 1

#Linking VPP instances
sh ./0_create_topology/0_1_linking_vpp_instances.sh
sleep 1

#Creating host instances
sh ./0_create_topology/0_2_creating_hosts.sh
sleep 1

#Setting SRv6
sh ./0_create_topology/0_3_setting_SRv6.sh
wait "$!"
