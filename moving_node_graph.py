"""
It's possible to rearrange the VPP processing graph in order to encpasulate the traffic flows: once a specific rule in the ACL is matched, the right encapsulation policy is applied. 
"""

#!/usr/bin/env python

from __future__ import print_function

import os
import fnmatch

from vpp_papi import VPPApiClient

VPP_JSON_DIR = '/usr/share/vpp/api/core/'
API_FILE_SUFFIX = '*.api.json'

def load_json_api_files(json_dir=VPP_JSON_DIR, suffix=API_FILE_SUFFIX):
	"""
	Loading json files that allows the connection with VPP instances.
	
	:param json_dir: json files directory
	:param suffix: tells what type of files in 'json_dir' directory we are looking for 
	:returns: returns an array containing the json files useful for connecting to VPP instances.
	
	|
	
	"""
	jsonfiles = []
	for root, dirnames, filenames in os.walk(json_dir):
		for filename in fnmatch.filter(filenames, suffix):
			jsonfiles.append(os.path.join(json_dir, filename))

	if not jsonfiles:
		print('Error: no json api files found')
		exit(-1)

	return jsonfiles

def connect_vpp(jsonfiles, VPP_ID, prefix):
	"""
	Try to connect to VPP instances.
	
	:param jsonfiles: is the list of json files found by 'load_json_api_files' function.
	:param VPP_ID: VPP instance name provided in the creation step (vppE1, vppE2)
	:param prefix: VPP instance prefix
	:returns: VPP instance to connect with
	
	|
	
	"""
	vpp = VPPApiClient(apifiles=jsonfiles)
	r = vpp.connect(VPP_ID, chroot_prefix=prefix)
	if r==0:
		print("VPP processing graph correctly rearranged.")
	else:
		print("Erro in rearranging VPP processing graph.")
	return vpp
	
def main():
	"""
	Once connected to VPP instance of nodes E1 and E2, with the 'add_node_next' function there will be a rearrange of their processing graph in order to make it possibile the application of forwarding rules.

	
	|
	
	"""
	#VppE1
	vpp1 = connect_vpp(load_json_api_files(), 'vppE1', 'vppE1')
	vpp1.api.add_node_next(node_name='ip6-inacl', next_name='sr-pl-rewrite-encaps')	#says that the next node on the VPP graph is sr-pl-rewrite-encaps if the one alredy visisted is ip6-inacl
	vpp1.disconnect()

	#VppE2
	vpp2 = connect_vpp(load_json_api_files(), 'vppE2', 'vppE2')
	vpp2.api.add_node_next(node_name='ip6-inacl', next_name='sr-pl-rewrite-encaps')	#says that the next node on the VPP graph is sr-pl-rewrite-encaps if the one alredy visisted is ip6-inacl
	vpp2.disconnect()

if __name__ == '__main__':
	main()
	
