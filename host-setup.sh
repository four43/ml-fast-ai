#!/bin/bash

# This script is designed to work with ubuntu 16.04 LTS

function install_nvidia_cuda {
	sudo mkdir -p /opt/nvidia-cuda
	cd /opt/nvidia-cuda

	# ensure system is updated and has basic build tools
	sudo apt-get update
	sudo apt-get --assume-yes upgrade
	sudo apt-get --assume-yes install build-essential gcc g++ make binutils
	sudo apt-get --assume-yes install software-properties-common

	# download and install GPU drivers
	wget "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.44-1_amd64.deb" -O "cuda-repo-ubuntu1604_8.0.44-1_amd64.deb"

	sudo dpkg -i cuda-repo-ubuntu1604_8.0.44-1_amd64.deb
	sudo apt-get update
	sudo apt-get -y install cuda
	sudo modprobe nvidia
	nvidia-smi

	read -p "The above nvidia-smi command should have returned information about your GPU, did it? (y/n)" -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		install_nvidia_docker;
	else
		echo "You should reboot your machine to get the kernel to accept the new nvidia cuda drivers. Then run this again."
	fi
}

function install_nvidia_docker {
	docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
	sudo apt-get purge -y nvidia-docker

	# Add the package repositories
	curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
	  sudo apt-key add -
	curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
	  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
	sudo apt-get update

	# Install nvidia-docker2 and reload the Docker daemon configuration
	sudo apt-get install -y nvidia-docker2
	sudo pkill -SIGHUP dockerd

	# Test nvidia-smi with the latest official CUDA image
	docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
	echo "The above nvidia-smi command (run in docker) should have returned information about your GPU";
}

read -p "This requires Ubuntu 16.04, an nVidia GPU, and docker already be installed. Ready to go?(y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	install_nvidia_cuda;
else
	exit 1;
fi
