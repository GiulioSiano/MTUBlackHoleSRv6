import subprocess

recPolActivated=0
option=-1

try:
	while True:
		print("0) Setup topology (running VPP instances, configuring link and SRv6)")
		print("1) TCP traffic (Policy 1 (a1::) ).")
		print("2) ICMPv6 traffic (Policy 2 (a3::) ).")
		print("3) Simultaneous TCP and ICMPv6 traffic.")
		print("4) Enable Recovery Policy.")
		print("5) Disable Recovery Policy.")
		print("9) Exit and kill VPP instances & delete interfaces.")
		print("10) Exit without killing VPP instances & deleting interfaces.")
		print("Recovery Policy status: FALSE") if recPolActivated==0 else print("Recovery Policy status: TRUE")
		option=input("Option: ")
		if str(option)=='0':
			print(" ")
			subprocess.call(["./0_create_topology/0_0_main.sh"])
			print("The topology has been configured.")
			print(" ")
		if str(option)=="1":
			print(" ")
			subprocess.call(["./1_TCP_traffic/tcp.sh"])
			print(" ")
		elif str(option)=="2":
			print(" ")
			subprocess.call(["./2_ICMPv6_traffic/2_1_ping.sh"])
			print(" ")
		elif str(option)=="3":
			print(" ")
			subprocess.call(["./3_TCP_ICMP/enable_flow.sh"])
			print(" ")
		elif str(option)=="4":
			print(" ")
			recPolActivated=1
			subprocess.call(["./1_1_enable_rec_policy.sh"])
			print(" ")
		elif str(option)=="5":
			print(" ")
			recPolActivated=0
			subprocess.call(["./1_2_disable_rec_policy.sh"])
			print(" ")
		elif str(option)=="6":
			subprocess.call(["./6_MTU_Path_Discovery.sh"])
			print(" ")
		elif str(option)=="9":
			subprocess.call(["./9_exit_kill_VPP.sh"])
			print("Envirnoment cleaned")
			raise KeyboardInterrupt
			break
		elif str(option)=="10":
			raise KeyboardInterrupt
			break
except KeyboardInterrupt:
	print("Exiting\n")

