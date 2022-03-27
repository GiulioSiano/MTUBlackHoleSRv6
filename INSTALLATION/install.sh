sudo apt install curl

sudo echo "deb [trusted=yes] https://packagecloud.io/fdio/release/ubuntu bionic main" > /etc/apt/sources.list.d/99fd.io.list
sudo curl -L https://packagecloud.io/fdio/release/gpgkey | sudo apt-key add -
sudo apt update
sudo apt install vpp=21.01.1-release 
sudo apt install vpp-plugin-core=21.01.1-release vpp-plugin-dpdk=21.01.1-release

sudo pip3 install vpp-papi
